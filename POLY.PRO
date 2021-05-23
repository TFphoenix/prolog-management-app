predicates
 polyspiral(integer)
 goal
  graphics(1,1,0),polyspiral(500).
 clauses
 polyspiral(X):-!,X<15000,
     forward(X),right(62),Y=X+100,polyspiral(Y).
     
  