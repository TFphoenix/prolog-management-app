domains
lp=symbol*
predicates
list(string,lp)
goal
readln(X),list(X,Y),write(Y).

clauses
list(S,[H|T]):-fronttoken(S,H,S1),!,list(S1,T).
list(_,[]).