domains
list=symbol*

predicates
arce(symbol,symbol)
leg(symbol,symbol)
run(symbol,symbol,list)
go(symbol,symbol,list,list)
member(symbol,list)


clauses
arce(ploiesti,bucuresti).
arce(bucuresti,rosiori).
arce(bucuresti,alex).
arce(alex,berlin).
arce(atena,rosiori).
arce(ploiesti,roma).
member(A,[A|_]).
member(A,[_|B]):-member(A,B).            
run(X,Y,L):-go(X,Y,L,[Y]).
go(X,X,L,L):-!.
go(X,Y,L,L1):-leg(Y,Z),not(member(Z,L1)),go(X,Z,L,[Z|L1]).
leg(Y,Z):-arce(Y,Z).
leg(Y,Z):-arce(Z,Y).
