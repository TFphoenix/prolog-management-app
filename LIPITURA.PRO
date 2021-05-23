domains
list=integer*
predicates
li(list,list,list)
clauses
li([],X,X).
li([A|B],C,[A|J]):-li(B,C,J).




