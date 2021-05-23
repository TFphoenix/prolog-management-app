% MODELS
domains 
    % general
	cnp = string

    % employee
	firstName = string
	lastName = string
	telefon = string 
	mail = string
	
    % experience
	workPlace = string
    workTitle = string
	yearsWorked = integer

    % education
    institution = string
    academicTitle = string
    yearsStudied = integer

    % formating
    tllc=integer*
    tldhc=string*

    % reports
    file=nsfr
	
    % lists
	EmployeeList = EmployeeType*
	ExperienceList = ExperienceType*
	EducationList = EducationType*

    % types
	EmployeeType = emplmodel(firstName, lastName, telefon, mail)
	ExperienceType = experiencemodel(workPlace, workTitle, yearsWorked)
	EducationType = educationmodel(institution, academicTitle, yearsStudied)
	
% DATABASES	
database-Employees
	employee(cnp, EmployeeType)

database-Experiences
	experience(cnp, ExperienceType)

database-Educations
    education(cnp, EducationType)

% FUNCTION DECLARATIONS
predicates
    % formating
	underline(integer,integer,char,integer)
    printTable(EmployeeList)
    printTableData(integer,integer,tldhc,tllc)
    printHeader(string)
    printFooter(integer)

    % general
	initDB
	menu 
	chooseOption(char)
	saveDB
	exitProgram

    % CRUD
    createEmployee
    searchEmployee
    deleteEmployee
    printExperience
    printEducation
	createExperience(string, integer)
    createEducation(string, integer)
	printEmployee(cnp, EmployeeList)
	printEmployee(EmployeeList)

    % reports
    generateReport(string)
    genrap(EmployeeList)

% FUNCTION DEFINITIONS
clauses
    % Initializes databases
	initDB():-
        % empty RAM memory
		retractall(employee(_,_)),
		retractall(experience(_,_)),
        % verifies databases existence
        existFile("DATA/PERSONAL.DTA"),
        existFile("DATA/WORK.DTA"),
        existFile("DATA/EDUC.DTA"),
        % read data
		consult("DATA/PERSONAL.DTA", Employees),
		consult("DATA/WORK.DTA", Experiences),
		consult("DATA/EDUC.DTA", Educations).
    initDB():-
		% Exception: Inexistent database
        makewindow(1,7,4,"Eroare la initializarea bazei de date",1,20,10,60),
        write("ERROR: Baza de date nu exista!"),nl,
        write("Iesire program... (ENTER=OK)"),
        readchar(_),
        exit(1).
		
    % Menu UI
	menu :-
		clearwindow,
	    makewindow(1,7,5,"EManagerApp - MENIU PRINCIPAL",1,12,12,60),
		write("1. Adaugare anagajat"),nl,
		write("2. Vizualizare anagajati"), nl,
		write("3. Cautare angajat dupa CNP"), nl,
		write("4. Stergere angajat dupa CNP"), nl,
		write("5. Salvati baza de date"), nl,
		write("6. Vizualizare experienta angajat"), nl,
		write("6. Vizualizare studii angajat"), nl,
		write("8. Genereaza raport"), nl,
		write("9. Iesire"), nl,
        write("Optiunea dvs: "),
		readchar(Optiune),
		chooseOption(Optiune),
		menu().    
		
    % 1. Adaugare anagajat
	chooseOption('1') :-
		 makewindow(2,7,2,"ADAUGARE ANGAJAT",13,12,9,60),
		 createEmployee(),
		 readchar(_),
		 removewindow.
    % 2. Vizualizare anagajati
	chooseOption('2') :-
		makewindow(2,7,9,"AFISEAZA ANGAJATI",13,12,9,60),
		findall(Col,employee(_, Col),EmpList),
        printHeader("Employees"),nl,
        printTable(EmpList),
        printFooter(0),
		readchar(_),
		removewindow.
    % 3. Cautare angajat dupa CNP
	chooseOption('3') :-
		makewindow(2,7,3,"CAUTARE ANGAJAT",13,12,9,60),
		searchEmployee(),
		readchar(_),
		removewindow.	
    % 4. Stergere angajat dupa CNP
	chooseOption('4') :-
		makewindow(2,7,12,"STERGERE ANGAJAT",13,12,9,60),
		deleteEmployee(),
        readchar(_),
		removewindow.
    % 5. Salvati baza de date
	chooseOption('5') :-
		makewindow(2,7,2,"SALVARE BAZA DE DATE",13,12,9,60),
		saveDB(),
		write("Baza de date a fost salvata cu succes!"),
        printFooter(0),
		readchar(_),
		removewindow.
    % 6. Vizualizare experienta angajat
	chooseOption('6') :-
		makewindow(2,7,9,"VIZUALIZARE EXPERIENTA ANGAJAT",13,12,9,60),
		printExperience(),
		readchar(_),
		removewindow.
    % 7. Vizualizare studii angajat
	chooseOption('7') :-
		makewindow(2,7,9,"VIZUALIZARE STUDII ANGAJAT",13,12,9,60),
		printEducation(),
		readchar(_),
		removewindow.
    % 8. Genereaza raport
	chooseOption('8') :-
		makewindow(2,7,3,"GENEREAZA RAPORT ANGAJATI",13,12,9,60),
		% generateReport(_),
        write("Nume raport: "),
        readln(RN),
        generateReport(RN),
        readchar(_),
		removewindow.
    chooseOption('8') :-
        printFooter(1),
        readchar(_),
		removewindow.
    % 9. Iesire
	chooseOption('9') :-
		retractall(employee(_,_)),
		exitProgram().
    chooseOption(_) :-
        cursor(9,2),write("                     "),
        cursor(9,2),write("Optiune eronata (ENTER=OK)"),
        readchar(_),
        menu().
	
    % Adds employee
    createEmployee :-
        write(">>> GENERAL (1/3)\n"),
        write("CNP: "),
        readln(CNP),
        write("Nume: "),
        readln(Lastname),
        write("Prenume: "),
        readln(Firstname),
        write("Telefon: "),
        readln(Telefon),
        write("Mail: "),
        readln(Mail),
        assertz(employee(CNP, emplmodel(Firstname, Lastname, Telefon, Mail))),
        nl,
        nl,
        saveDB(),
        write("Angajatul a fost adaugat cu succes!\n\n"),
        % experience
        write(">>> CARIERA (2/3)\n"),
        write("Locuri de munca precedente: "),
        readint(ExperienceNr),nl,
        createExperience(CNP, ExperienceNr),
        % education
        write(">>> EDUCATIE (3/3)\n"),
        write("Numar studii: "),
        readint(EducationeNr),nl,
        createEducation(CNP, EducationeNr),
        saveDB(),
        printFooter(2).
    createEmployee :-
        printFooter(1).

    % Search for employee
    searchEmployee :-
        write("CNP: "),
		readln(CNP),nl,
		findall(Col,employee(CNP, Col),EmpList),
		printEmployee(EmpList),
        printFooter(0).
    searchEmployee :-
        printFooter(1).

    % Delete employee
    deleteEmployee :-
        write("CNP: "),
		readln(CNP),
		employee(CNP, X),
		write(X),
		retract(employee(CNP, _)),nl,
		saveDB(),
		write("Angajatul a fost sters cu succes!\n"),
		saveDB().
    deleteEmployee :-
        printFooter(1).

    % Prints experience of given employee
    printExperience :-
        write("CNP: "),
		readln(CNP),
		findall(Col, experience(CNP, Col), ExpList),
		write(ExpList),
        printFooter(0).
    printExperience :-
        printFooter(1).

    % Prints education of given employee
    printEducation :-
        write("CNP: "),
		readln(CNP),
		findall(Col, education(CNP, Col), ExpList),
		write(ExpList),
        printFooter(0).
    printEducation :-
        printFooter(1).

    % Adds workplace
	createExperience(_, 0):- 
		nl.	
	createExperience(CNP, ExperienceNr) :-
		write("Introduceti numele locului lucrat:"),
		readln(LocLucrat),
        write("Introduceti titlul pozitiei pe care s-a lucrat:"),
		readln(Pozitie),
		write("Intruduceti numarul de ani:"),
		readint(AniLucrati),
		assertz(experience(CNP, experiencemodel(LocLucrat, Pozitie, AniLucrati))),
		nl,
		Loc = ExperienceNr - 1,
		createExperience(CNP, Loc).

    % Adds academic path
    createEducation(_, 0):- 
		nl.	
        createEducation(CNP, EducationNr) :-
		write("Introduceti numele institutiei:"),
		readln(Institutie),
        write("Introduceti titlul academic:"),
		readln(Titlu),
		write("Intruduceti numarul de ani:"),
		readint(Ani),
		assertz(education(CNP, educationmodel(Institutie, Titlu, Ani))),
		nl,
		Loc = EducationNr - 1,
		createEducation(CNP, Loc).
		
    % Prints employee
	printEmployee([]).
	printEmployee([emplmodel(Nume, Prenume, Telefon, Mail) | RL]):-
		employee(CNP, emplmodel(Nume, Prenume, Telefon, Mail)),
		write(CNP),
		write(Nume),
		write(Prenume),
		write(Telefon),
		write(Mail),nl,
		printEmployee(RL).
	printEmployee(Nume, [emplmodel( Name, _, _, _) | _]) :-
		write(Nume),
		write(Name).
    
    % Prints table header
    printHeader("Employees") :-
        write("Angajati:"),nl,
        LA=1,
        printTableData(1,0,["Nume","Prenume","Telefon","Mail"],[10,10,15,15]),
        LS=LA+1,
        underline(LS,0,'-',55).

    % Prints table
    printTable([]).
    printTable([emplmodel(Nume, Prenume, Telefon, Mail) | RL]):-
        cursor(L,_),
        L>0,
        L<6,
        printTableData(L,0,[Nume,Prenume,Telefon,Mail],[10,10,15,15]),nl,
        cursor(LC,_),cursor(LC,0),
        printTable(RL).
    
    % Prints table data cells
    printTableData(_,_,[],[]).
    printTableData(L,CC,[Col|RLC],[LCol|RLL]):-
        L<6,
        cursor(L,CC),write(Col),
        UCC=CC+LCol,
        printTableData(L,UCC,RLC,RLL).
		
    % Generates underline
	underline(_,_,_,0).
	underline(Lin,Col,CaractPtSub,CaractLungime):-
		cursor(Lin,Col),write(CaractPtSub),
		CaractRamase=CaractLungime-1,
		CI=Col+1,
		underline(Lin,CI,CaractPtSub,CaractRamase).        
	
    % Prints window footer
    printFooter(0) :-
        write("\n\tApasati orice tasta pentru a reveni...").
    printFooter(1) :-
        write("\n\t<!> EROARE\n\tApasati orice tasta pentru a reveni...").
    printFooter(2) :-
        write("\n\t<*> SUCCES\n\tApasati orice tasta pentru a reveni...").

    % Generates report of employees
    generateReport(ReportName) :-
        openwrite(nsfr,ReportName),
        writedevice(nsfr),
        findall(Col,employee(_, Col),EmpList),
        genrap(EmpList),
        closefile(nsfr),
        writedevice(screen),
        printFooter(2).
    generateReport(_) :-
        printFooter(1).

    % Generates report
    genrap([]).
    genrap([emplmodel(Nume, Prenume, Telefon, Mail) | RL]):-
        write(Nume,"/",Prenume,"/",Telefon,"/",Mail),nl,
        genrap(RL).

    % Save databases
	saveDB() :-
		save("DATA/PERSONAL.DTA", Employees),
        save("DATA/WORK.DTA", Experiences),
		save("DATA/EDUC.DTA", Educations).
	
    % Exits program
	exitProgram() :-
		retractall(employee(_,_)),
		exit(0).
	
% INDEX
goal
	initDB,
	menu.