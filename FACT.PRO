%trace
predicates
  fact(integer,integer)
clauses

  % Oprirea autoapelurilor
  fact(0,1).

  % Apelul recursiv
  fact(N,Rezultat):-
    N>0,
    N1=N-1,
    fact(N1,Rez1),
    Rezultat=Rez1*N.  