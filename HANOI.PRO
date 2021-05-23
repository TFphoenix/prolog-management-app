domains
gg=char
predicates
muta(gg,gg,gg,integer)
goal
nl,nl,nl,
muta('a','b','c',2).
clauses
muta(_,_,_,0):-!.
muta(A,B,C,N):-N1=N-1,muta(A,C,B,N1),
write("muta un disc de pe tija ",A," pe tija ",C),nl,
               N2=N-1,muta(B,A,C,N2).