predicates

      meniu()
      afisare_interfata()
      calcul_acop()
      
      
goal

     clearwindow,
    makewindow(1,6,7,"Roof Commander V.1.42 Beta!!!",0,0,25,80),
    nl,nl,
    afisare_interfata,nl,
    meniu,nl,
    calcul_acop,
    readint(T). 


clauses

   
      afisare_interfata():-!,nl,
 
      write("----------------------------------"),
      write("ROOF COMMANDER---------------------------------------"),
      write("------------------------------------------------------------").

      meniu():-!,nl,

      write("Bine ati venit in mediu de lucru ROOF Commander!!!"),nl,
      write("Pentru a putea calcula necesarul de material este nevoie de aria acoperisului!!!"),nl.
      
      calcul_acop():-!,nl,
      
    
      
          write("Introduceti lungimea si latimea acoperisului:"),
          readreal(A),nl,readreal(B),nl, 
          ARIA=A*B,nl,
          write("Aria acoperisului dvs este de : ",ARIA),write(" metri patrati"),nl,nl,
          write("In cele ce urmeaza veti alfa ce cantitate de materiale aveti nevoie."),
             nl,nl,
          write("Tiglele disponibile sunt de 2 feluri:") ,nl,
                    write("***Tigle metalice - arie de acoperire 1.1 m^2/buc, 1.2 lei/buc"),nl,
                    write("***Tigle argila - arie de acoperire 0.6 m^2/buc,0.7 lei/buc"),nl,
          R=ARIA/0.6,
          write("Pentru acoperisul dvs aveti nevoie de:",R),write(" tigle argila"),nl,
          REZ=R*0.7,
          write("Acestea ar costa:",REZ),write(" lei"),nl,
          Z=ARIA/1.1,
          write("Pentru acoperisul dvs aveti nevoie de:",Z),write(" tigle metalice"),nl,
          REx=R*1.1,
          write("Acestea ar costa:",REX),write(" lei"),nl,readln(Y),

 
              nl,nl,
          write("<<<LATI NECESARI:"),nl,

          write("Suparafata unui lat este de 1.8m^2 iar pretul este de 5 lei"),nl,
          REZZ=(ARIA/1.8)/5,
          write("Numarul de lati de care aveti nevoie este: ",REZZ),nl,
          COST=REZZ*5,
          write("Acesti lati ar costa:",COST),write(" lei"),nl,readln(P),

        
          
          nl,nl,          
          write("<<<CUIE NECESARE:"),nl,
          write("Numarul de cuie necesare pentru un lat este de 10 buc a 0.2 lei/buc"),nl,
          K=REZZ*10,
          COSTUL=K*0.2,
          write("Cuiele vor costa in total: ",COSTUL),write("lei"),nl,readln(I),

          nl,nl,
          write("<<<LUNGIME BURLAN:"),nl,    
          PER=2*A+2*B,
          write("Lungimea burlanului de care aveti nevoie este:",PER),write(" metri."),nl,readln(H).

















