database
xpositive(symbol,symbol)
xnegative(symbol,symbol)

predicates
 he(symbol)
 it_is(symbol)
 positive(symbol,symbol)
 negative(symbol,symbol)
 ask(symbol,symbol,symbol)
 remember(symbol,symbol,symbol)
 run
 clearfacts
 
 goal
 run.
 
clauses

 positive(X,Y):-xpositive(X,Y),!.
 positive(X,Y):-not(xnegative(X,Y)),ask(X,Y,yes).
 negative(X,Y):-xnegative(X,Y).
 negative(X,Y):-not(xpositive(X,Y)),ask(X,Y,no).
 ask(X,Y,yes):-write(X," he ",Y,"\n"),
 readln(Reply),frontchar(Reply,'y',_),!,
 remember(X,Y,yes).
 ask(X,Y,no):-write(X," he ",Y,"\n"),
 readln(Reply),frontchar(Reply,'n',_),
 remember(X,Y,no).
 remember(X,Y,yes):-asserta(xpositive(X,Y)).
 remember(X,Y,no):-asserta(xnegative(X,Y)).
 clearfacts:-retract(xpositive(_,_)),fail.
 clearfacts:-retract(xnegative(_,_)),fail.
 clearfacts:-write("\n\nPress space bar to exit\n"),
 readchar(_).
he(bulinov):-it_is(student),positive(is,fat),positive(is,son_of_a_bitch),
negative(is,clever),positive(is,gay),
positive(does,lick_asses),positive(is,ped_fectionist).
he(gene):-it_is(student),positive(is,skinny),positive(is,son_of_a_bitch),
positive(is,clever),positive(does,play_bridge).
he(craiu):-it_is(prof),positive(eats,shit),negative(is,clever),
positive(can,be_bribed),positive(is,handsome).
he(bisca):-it_is(prof),positive(is,fat),positive(is,clever),
negative(is,handsome),positive(loves,c),positive(hates,pascal).
he(victoras):-it_is(prof),positive(is,handsome),positive(loves,girls),
positive(has,blue_eyes).
he(mocanu):-it_is(prof),positive(has,blue_jeans),negative(is,clever),
positive(is,world_wide_known),write("THERE CAN BE ONLY ONE...").
he(ichim):-it_is(prof),positive(is,tiny),negative(is,clever),
positive(eats,shit),positive(makes,grammar_faults).
he(maitre):-it_is(student),positive(has,strange_eyes),
positive(is,a_bit_insane).
it_is(student):-negative(has,money).
it_is(prof):-positive(has,money).
run:-he(X),!,write("\nthe guy is ",X),clearfacts.
