domains
list=char*
predicates
li(list,list,list)
reverse(list,list)
clauses
li([],X,X).
li([A|B],C,[A|J]):-li(B,C,J).
reverse([],[]):-!.
reverse([A|B],L):-reverse(B,LL),li(LL,[A],L).




