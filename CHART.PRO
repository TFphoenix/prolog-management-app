domains
list=symbol*

predicates
arce(symbol,symbol)
leg(symbol,symbol)
go(symbol,symbol)
ruta(symbol,symbol,list)
member(symbol,list)
writelist(list)


clauses
arce(ploiesti,bucuresti).
arce(bucuresti,rosiori).
arce(alexandria,zimnicea).
arce(zimnicea,rosiori).
arce(zimnicea,dortmund).
arce(toplita,bacau).
arce(focsani,buzau).
arce(buzau,ploiesti).
arce(bacau,focsani).
arce(sibiu,toplita).
arce(brasov,sibiu).
arce(brasov,ploiesti).
arce(sibiu,timisoara).
arce(belgrad,timisoara).
leg(X,Y):-arce(X,Y).
leg(X,Y):-arce(Y,X).
go(X,Y):-ruta(X,Y,[X]).
go(_,_).
ruta(X,X,L):-writelist(L).
ruta(X,Y,L):-leg(X,Z),not(member(Z,L)),
ruta(Z,Y,[Z|L]).
member(A,[A|_]).
member(A,[_|B]):-member(A,B).            
writelist([]).
writelist([A|B]):-writelist(B),nl,write(A).