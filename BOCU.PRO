% trace
domains
  % 
  file=nsfr  
  % Tip lista de string-uri
  % utila la afisarea formatata a datelor si a antetelor de rapoarte
  % daca este cazul
  tldhc=string*

  % Tip lista de intregi
  % utila la transmiterea informatiilor de formatare a datelor
  tllc=integer*

  % Tip lista de date despre studenti
  % functorizate pentru a favoriza utilizarea predicatului <findall>
  tlstud=tstud*
  
  % Tip date student functorizate
  tstud=stud(string,string)


database-BDF
  % Pastrare nume baza de fapte studenti
  % daca exista  
  numeBFS(string)
    
database-Studenti
  % Modelare ca predicat a datelor unui student
  % via <tstud>
  student(tstud)
      
predicates
  % Creare baza de fapte cu date despre studenti
  % Faptele sunt adaugate in ram
  % via <assert>
  creBFS

  % Consultare baza de fapte cu date despre studenti
  % via <tlstud>
  consBFS(tlstud)

  % Afisare formatata pe ecran
  % a datelor unui student
  % P1->Linia pe care se face afisarea
  % P2->Coloana de inceput a zonei de afisarea
  % P3->Lista valorilor de afisat transformate in string-uri
  % P4->Lista lungimii zonelor de afisare aferente valorilor 
  scrt(integer,integer,tldhc,tllc)

  % Subliniere formatata
  % P1->Linia pe care se face sublinierea
  % P2->Coloana de unde incepe sublinierea
  % P3->Caracterul cu care se face sublinierea
  % P4->Lungimea sublinierii in caractere
  subl(integer,integer,char,integer)

  salvBFS(string)
  gen_rapBFS(string)
  genrap(tlstud)
 
  main
  init
  run
  prelo(char)
  exec(char)
  valop(char)
  
  citras(char)
  validras(char)
  
    
clauses
  gen_rapBFS(NFRap):-
    openwrite(nsfr,NFRap),
    writedevice(nsfr),
    findall(ColS,student(ColS),LDS),
    genrap(LDS),
    closefile(nsfr),
    writedevice(screen).

  genrap([]).
  
  genrap([stud(N,P)|RL]):-
    write(N,"/",P),nl,
    genrap(RL).
    
  
  
  
  salvBFS(NBF):-
    save(NBF,Studenti).
 
  init:-
    existfile("BDF.bdf"),
    consult("BDF.bdf",BDF),
    numeBFS(NBF),
    consult(NBF,Studenti).
  init:-
    clearwindow,
    cursor(12,2),write("Trebuie creata baza de fapte!..."),
    readchar(_).
      
  main:-
    init,
    run.
   
  validras(Ras):-
    Ras='\13';
    Ras='\27'.
    
  citras(Ras):-!,
    readchar(Ras),
    validras(Ras).

  citras(Ras):-
    readchar(Ras).

        
  creBFS:-
    clearwindow,
    cursor(1,2),write("Nume student   :"),readln(NS),
    cursor(2,2),write("Prenume student:"),readln(PS),
    assert(student(stud(NS,PS))),
    cursor(4,2),write("<ENTER>-pentru continuare/<ESC>-terminare"),
    citras(Ras),
    Ras='\13',
    creBFS.
  
  creBFS:-
    numeBFS(NBF), 
    salvBFS(NBF).
  
  consBFS([]).  

  consBFS([stud(N,P)|RL]):-
    cursor(LA,_),
    LA=0,
    scrt(LA,10,["Nume","Prenume"],[15,15]),
    LS=LA+1,
    subl(LS,10,'-',30),
    nl,
    cursor(LDS,_),
    scrt(LDS,10,[N,P],[15,15]),nl,
    consBFS(RL).
  
  consBFS([stud(N,P)|RL]):-
    cursor(L,_),
    L>0,
    L<6,
    scrt(L,10,[N,P],[15,15]),nl,
    cursor(LC,_),cursor(LC,10),
    consBFS(RL).
    
  consBFS([stud(N,P)|RL]):-
    cursor(6,10),write("Apasati o tasta pentru continuare..."),
    readchar(_),
    clearwindow,
    cursor(LA,_),
    scrt(LA,10,["Nume","Prenume"],[15,15]),
    LS=LA+1,
    subl(LS,10,'-',30),
    nl,
    cursor(LDS,_),
    scrt(LDS,10,[N,P],[15,15]),nl,
    consBFS(RL).
  
  scrt(_,_,[],[]).
  scrt(L,CC,[Col|RLC],[LCol|RLL]):-
    L<6,
    cursor(L,CC),write(Col),
    UCC=CC+LCol,
    scrt(L,UCC,RLC,RLL).
  
  scrt(L,CC,[Col|RLC],[LCol|RLL]):-
    cursor(L,CC),
    write("Apasati o tasta pentru continuare..."),
    readchar(_),
    clearwindow,
    cursor(LC,_),
    scrt(LC,CC,[Col|RLC],[LCol|RLL]).
  
  
  subl(_,_,_,0).
  
  subl(L,C,Car,NCR):-
    cursor(L,C),write(Car),
    NCRI=NCR-1,
    CI=C+1,
    subl(L,CI,Car,NCRI).            
  
  run:-
    prelo(O),
    exec(O),
    run.
  
  prelo(O):-
    clearwindow,
    makewindow(1,6,7,"Meniu aplicatie <EDPS>",1,12,12,60),
    cursor(1,2),write("1-Consultare baza de fapte"),
    cursor(2,2),write("2-Generare raport"),
    cursor(3,2),write("3-Adaugare date despre studenti"),
    cursor(4,2),write("4-Consultare raport din arhiva"),
    cursor(5,2),write("5-Arhivare baza de fapte aplicatie"),
    cursor(6,2),write("6-Creare baza de fapte aplicatie"),
    cursor(7,2),write("7-Terminare"),    
    cursor(9,2),write("Optiunea Dvs.:"),
    readchar(O),
    valop(O).
  
  prelo(O):-
    cursor(9,2),write("                     "),
    cursor(9,2),write("Optiune eronata/<ENTER> pentru continuare"),
    readchar(_),
    prelo(O).
      
  valop(O):-
    O='1';
    O='2';
    O='3';
    O='4';    
    O='5';  
    O='6';
    O='7'.
  
  %----------
  exec('1'):-!,
    makewindow(2,6,7,"Consultare baza de fapte",13,12,9,60),
    clearwindow,
    findall(Col,student(Col),LDS),
    consBFS(LDS),
    readchar(_),
    removewindow.

  exec('2'):-!,
    makewindow(2,6,7,"Generare raport",13,12,9,60),
    cursor(3,2),write("Nume raport:"),
    readln(NFR),
    gen_rapBFS(NFR),
    readchar(_),
    removewindow.

  exec('3'):-!,
    makewindow(2,6,7,"Adaugare date despre studenti",13,12,9,60),
    creBFS,
    numeBFS(NBF),
    save(NBF,Studenti),
    removewindow.
 
   exec('4'):-!,
    makewindow(2,6,7,"Consultare raport disponibil ",13,12,9,60),
    cursor(4,2),write("Nume raport:"),
    readln(NR),
    file_str(NR,VSF),
    display(VSF),
    readchar(_),
    removewindow.
   
  exec('5'):-!,
    makewindow(2,6,7,"Arhivare baza de fapte aplicatie",13,12,9,60),
    cursor(4,2),write("Neimplementata"),
    readchar(_),
    removewindow.

  exec('6'):-!,
    makewindow(2,6,7,"Creare baza de fapte studenti...",13,12,9,60),
    cursor(4,2),write("Nume baza de fapte:"),
    readln(NBF),
    assert(numeBFS(NBF)),
    save("BDF.bdf",BDF),
    removewindow.

  exec('7'):-!,
    makewindow(2,6,7,"Terminare",13,12,9,60),
    cursor(4,2),write("La revedere"),
    readchar(_),
    removewindow,
    numeBFS(NBF),
    save(NBF,Studenti),
    exit(0).

      
goal
  main.
  