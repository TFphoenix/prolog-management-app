domains
list=integer*

predicates
flat(list)
flat(integer)
clauses
flat([]):-!.
flat([A|B]):-!,flat(A),flat(B).
flat(A):-write(A).