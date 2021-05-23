domains
nume=symbol
lista=nume*

predicates
change(nume,lista)
alter(lista,lista)
ppr(lista)
run
readlist(lista)

goal
run.

clauses
change(you,[i]).
change(are,[aint]).
change(your,[my]).
change(fuck,[fuck_yourself]).
change(is,[isnt]).
change(X,[X]).
alter([],[]):-!.
alter([A|B],[H|T]):-change(A,[H]),alter(B,T),!.
ppr([]).
ppr([A|B]):-write(A," "),ppr(B).
run:-readlist(X),alter(X,Y),ppr(Y).
readlist([H|T]):-readln(H),!,readlist(T).
readlist([]).