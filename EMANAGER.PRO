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

    % BOCU
    tllc=integer*
    tldhc=string*
	
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

    % general
	initDB
	menu 
	alegereOptiune(char)
	saveDB
	iesire

    % CRUD
	adaugareLocMunca(string, integer)
	afiseazaEmpl(cnp, EmployeeList)
	afiseazaEmpl(EmployeeList)

% FUNCTION DEFINITIONS
clauses
    % Initializes databases
	initDB():-
		retractall(employee(_,_)),
		retractall(experience(_,_)),
		consult("DATA/PERSONAL.DTA", Employees),
		consult("DATA/WORK.DTA", Experiences),
		consult("DATA/EDUC.DTA", Educations).
		
    % Menu UI
	menu :-
		clearwindow,
	    makewindow(1,6,7,"EManagerApp - MENIU PRINCIPAL",1,12,12,60),
		write("1. Adaugare anagajat"),nl,
		write("2. Vizualizare anagajati"), nl,
		write("3. Cautare angajat dupa CNP"), nl,
		write("4. Stergere angajat dupa CNP"), nl,
		write("5. Salvati baza de date"), nl,
		write("6. Vizualizare experienta angajat"), nl,
		write("7. Genereaza raport"), nl,
		write("9. Iesire"), nl,
		readchar(Optiune),
		alegereOptiune(Optiune),
		menu().
		
    % 1. Adaugare anagajat
	alegereOptiune('1') :-
		 makewindow(2,6,7,"ADAUGARE ANGAJAT",13,12,9,60),
		 write("Introdu CNP angajatului: "),
		 readln(CNP),
		 write("Introdu nume familie angajatului: "),
		 readln(Lastname),
		 write("Introdu prenume angajatului: "),
		 readln(Firstname),
		 write("Introdu telefon angajatului: "),
		 readln(Telefon),
		 write("Introdu mail angajatului: "),
		 readln(Mail),
		 assertz(employee(CNP, emplmodel(Firstname, Lastname, Telefon, Mail))),
		 nl,
		 nl,
		 saveDB(),
		 write("Angajatul a fost adaugat cu succes!\n"),
		 write("Introduceti cate locuri de munca a avut angajatul in trecut: "),
		 readint(LocuriTrecut),nl,
		 adaugareLocMunca(CNP, LocuriTrecut),
		 saveDB(),
		 readchar(_),
		 removewindow.
	
    % 2. Vizualizare anagajati
	alegereOptiune('2') :-
		makewindow(2,6,7,"AFISEAZA ANGAJATI",13,12,9,60),
		findall(Col,employee(_, Col),EmpList),
        printHeader("Employees"),nl,
        printTable(EmpList),
		readchar(_),
		removewindow.

    % 3. Cautare angajat dupa CNP
	alegereOptiune('3') :-
		makewindow(2,6,7,"CAUTARE ANGAJAT",13,12,9,60),
		write("Introdu CNP: "),
		readln(CNP),nl,
		findall(Col,employee(CNP, Col),EmpList),
		afiseazaEmpl(EmpList),
		readchar(_),
		removewindow.
		
    % 4. Stergere angajat dupa CNP
	alegereOptiune('4') :-
		makewindow(2,6,7,"STERGERE ANGAJAT",13,12,9,60),
		write("Introdu CNP: "),
		readln(CNP),
		employee(CNP, X),
		write(X),
		retract(employee(CNP, _)),nl,
		saveDB(),
		write("Userul a fost sters"),
		saveDB(),
		removewindow.	
		
    % 5. Salvati baza de date
	alegereOptiune('5') :-
		makewindow(2,6,7,"SALVARE BAZA DE DATE",13,12,9,60),
		saveDB(),
		write("Baza de date a fost salvata cu succes!"),
		readchar(_),
		removewindow.
	
    % 6. Vizualizare experienta angajat
	alegereOptiune('6') :-
		makewindow(2,6,7,"VIZUALIZARE EXPERIENTA ANGAJAT",13,12,9,60),
		write("Introdu CNP pentru anagajat: "),
		readln(CNP),
		findall(Col, experience(CNP, Col), ExpList),
		write(ExpList),
		readchar(_),
		removewindow.
		
    % 7. Genereaza raport
	alegereOptiune('7') :-
		makewindow(2,6,7,"GENEREAZA RAPORT",13,12,9,60),
		write(""),
		removewindow.
		
    % 9. Iesire
	alegereOptiune('9') :-
		retractall(employee(_,_)),
		iesire().
	
    % Adds workplace
	adaugareLocMunca(_, 0):- 
		nl.	
		
	adaugareLocMunca(CNP, LocuriTrecut) :-
		write("Introduceti numele locului lucrat:"),
		readln(LocLucrat),
        write("Introduceti titlul pozitiei pe care s-a lucrat:"),
		readln(Pozitie),
		write("Intruduceti timpul de ani ca numar:"),
		readint(AniLucrati),
		assertz(experience(CNP, experiencemodel(LocLucrat, Pozitie, AniLucrati))),
		nl,
		Loc = LocuriTrecut - 1,
		adaugareLocMunca(CNP, Loc).
		
    % Print functions
	afiseazaEmpl([]).

	afiseazaEmpl([emplmodel(Nume, Prenume, Telefon, Mail) | RL]):-
		employee(CNP, emplmodel(Nume, Prenume, Telefon, Mail)),
		write(CNP),
		write(Nume),
		write(Prenume),
		write(Telefon),
		write(Mail),nl,
		afiseazaEmpl(RL).
	
	afiseazaEmpl(Nume, [emplmodel( Name, _, _, _) | _]) :-
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
	
    % Save databases
	saveDB() :-
		save("DATA/PERSONAL.DTA", Employees),
        save("DATA/WORK.DTA", Experiences),
		save("DATA/EDUC.DTA", Educations).
	
    % Exits program
	iesire() :-
		retractall(employee(_,_)),
		exit(0).
	
% INDEX
goal
	initDB,
	menu.