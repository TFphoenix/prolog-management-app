predicates
start
run(integer)
dosums
setw
clrw

goal
start.

clauses
start:-setw,dosums.
setw:-makewindow(1,78,24,"",0,0,25,60),
makewindow(1,78,24,"Left operand",2,5,5,25),
makewindow(2,18,7,"",2,35,5,10),
nl,write("PLUS"),
makewindow(2,7,7,"Right operand",2,50,5,25),
makewindow(3,7,7,"Gives",10,27,5,25),
makewindow(4,7,7,"",17,22,5,35).
dosums:-run(_),clrw,dosums.
run(Z):-shiftwindow(1),
cursor(2,1),readint(X),shiftwindow(2),
cursor(2,10),readint(Y),
shiftwindow(3),Z=X+Y,cursor(2,10),write(Z),
shiftwindow(4),
write("Press space bar"),readchar(_).
clrw:-shiftwindow(1),clearwindow,
shiftwindow(2),clearwindow,
shiftwindow(3),clearwindow,
shiftwindow(4),clearwindow.