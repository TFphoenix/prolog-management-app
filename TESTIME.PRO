predicates
  repeta
clauses
  repeta:-
    date(Anul,Luna,Ziua),
    time(Ora,Minutul,Secunda,_),
    cursor(1,60),
    write(Ziua,":",Luna,":",Anul," "),
    write(Ora,":",Minutul,":",Secunda),
    repeta.
goal
  repeta.