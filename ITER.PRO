domains
  file=fisier

predicates
  repeta(integer)
clauses  
  repeta(0):-!.
  repeta(Contor):-
    readln(Linie),
    write(Linie),
    nl,
    NC=Contor-1,
    repeta(NC).
goal
  clearwindow,
  openread(fisier,"iter.pro"),
  readdevice(fisier),
  repeta(20),
  readdevice(keyboard),
  keypressed.    
    