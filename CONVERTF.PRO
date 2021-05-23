trace
/*Convertirea la UPCASE a datelor unui fisier text*/
domains
   file = input; output

predicates
   convert_file
   repfile(FILE)

goal
   clearwindow,
   write("Numele fisierului pe care doriti sa il transformati:"),
   readln(InputFileName),
   write("Fisierul rezultat:"),
   readln(OutputFileName),
   openread(input, InputFileName),
   readdevice(input), 
   openwrite(output, OutputFileName),
   writedevice(output), 
   convert_file,
   closefile(input),
   closefile(output).

clauses
   convert_file :-
      repfile(input),
      readln(Ln),
      upper_lower(LnInUpper,Ln),          
      write(LnInUpper),nl,
      fail.
   convert_file.

   repfile(_).
   repfile(F):- not(eof(F)),repfile(F).
