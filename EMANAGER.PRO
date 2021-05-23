% MODELS
domains 
	firstName = string
	lastName = string
	telefon = string 
	mail = string
	cnp = integer
	
	lastWorkedPlace = string
	timeWorked = integer
	
	EmplList = EmplType*
	ExperienceList = ExperienceType*
	EmplType = emplmodel(firstName, lastName, telefon, mail)
	ExperienceType = experiencemodel(lastWorkedPlace, timeWorked)
	
% DATABASES	
database 
	employee(cnp, EmplType)
	experience(cnp, ExperienceType)

% FUNCTION DECLARATIONS
predicates
	% Subliniere formatata
	% P1->Linia pe care se face sublinierea
	% P2->Coloana de unde incepe sublinierea
	% P3->Caracterul cu care se face sublinierea
	% P4->Lungimea sublinierii in caracter
	underline(integer,integer,char,integer)

	initDB
	menu 
	alegereOptiune(char)
	saveDB
	iesire

	adaugareLocMunca(integer, integer)
	afiseazaEmpl(cnp, EmplList)
	afiseazaEmpl(EmplList)

% FUNCTION DEFINITIONS
clauses
	initDB():-
		retractall(employee(_,_)),
		retractall(experience(_,_)),
		consult("DATA/PERSONAL.DTA"),
		consult("DATA/WORK.DTA").
		% consult("DATA/EDUCATION.DTA").
		
	menu :-
		clearwindow,
	    makewindow(1,6,7,"MAIN MENU WINDOW",1,12,12,60),
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
		 makewindow(2,6,7,"Adaugare angajat WINDOW",13,12,9,60),
		 write("Introdu CNP angajatului: "),
		 readint(CNP),
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
		 write("Angajatul a fost adaugat cu succes!"),
		 write("Introduceti cate locuri de munca a avut angajatul in trecut: "),
		 readint(LocuriTrecut),nl,
		 adaugareLocMunca(CNP, LocuriTrecut),
		 saveDB(),
		 readchar(_),
		 removewindow.
	
    % 2. Vizualizare anagajati
	alegereOptiune('2') :-
		makewindow(2,6,7,"Afiseaza toti angajatii",13,12,9,60),
		write("See employee"),nl,
		findall(Col,employee(_, Col),EmpList),
		cursor(Lin, _),
		LS = Lin + 1,
		underline(LS, 10, '-', 30),nl,
		afiseazaEmpl(EmpList),
		readchar(_),
		removewindow.
		
    % 3. Cautare angajat dupa CNP
	alegereOptiune('3') :-
		makewindow(2,6,7,"Cautare angajat dupa CNP",13,12,9,60),
		write("Introdu CNP: "),
		readint(CNP),nl,
		findall(Col,employee(CNP, Col),EmpList),
		afiseazaEmpl(EmpList),
		readchar(_),
		removewindow.
		
    % 4. Stergere angajat dupa CNP
	alegereOptiune('4') :-
		makewindow(2,6,7,"STERGERE ANGAJAT",13,12,9,60),
		write("Introdu CNP: "),
		readint(CNP),
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
		readint(CNP),
		findall(Col, experience(CNP, Col), ExpList),
		write(ExpList),
		readchar(_),
		removewindow.
		
    % 7. Genereaza raport
	alegereOptiune('7') :-
		makewindow(2,6,7,"Vizualizare experienta angajat",13,12,9,60),
		write(""),
		removewindow.
		
    % 9. Iesire
	alegereOptiune('9') :-
		retractall(employee(_,_)),
		iesire().
	
	adaugareLocMunca(_, 0):- 
		nl.	
		
	adaugareLocMunca(CNP, LocuriTrecut) :-
		write("Introduceti numele locului lucrat:"),
		readln(LocLucrat),
		write("Intruduceti timpul de ani ca numar:"),
		readint(AniLucrati),
		assertz(experience(CNP, experiencemodel(LocLucrat, AniLucrati))),
		nl,
		Loc = LocuriTrecut - 1,
		adaugareLocMunca(CNP, Loc).
		
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
		
	underline(_,_,_,0).
  
	underline(Lin,Col,CaractPtSub,CaractLungime):-
		cursor(Lin,Col),write(CaractPtSub),
		CaractRamase=CaractLungime-1,
		CI=Col+1,
		underline(Lin,CI,CaractPtSub,CaractRamase).        
	
	saveDB() :-
		save("DATA/PERSONAL.DTA").
	
	iesire() :-
		retractall(employee(_,_)),
		exit(0).
	
% INDEX
goal
	initDB,
	menu.