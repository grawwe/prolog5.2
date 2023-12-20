DOMAINS 
  conditions = number*
  number = integer
  category = string
  
global facts - all_rules
  topic(category)
  rule(number, category, category, conditions)
  cond(number, category)
  yes(number)
  no(number)
  
PREDICATES
  do_expert_job
  nondeterm show_menu
  nondeterm do_consulting
  nondeterm process(integer)
  goes(category)
  clear
  eval_reply(char)
  nondeterm go(category)
  nondeterm check(number, conditions)
  inpo(number, number, string)
  do_answer(number, string, number, number)
  
CLAUSES 
  do_expert_job:-
    show_menu, nl, 
    readchar(_), exit.
  
  show_menu:-
    write("Welcome to Menu: "), nl,
    write("You have 2 option (just type a random digit) :) "), nl,
    write("===>  1 - It's time to buy a new camera!"), nl,
    write("===>  0 - Exit program peacfully without violence"), nl,
    readint(Choice), process(Choice).
    
  process(1):-
    do_consulting.
  process(0):-
    exit.
    
  do_consulting:-
    goes(Mygoal), 
    go(Mygoal), !.
  do_consulting:-
    nl, write("If you see this message, that means that you typed 'no' 2 times in a row ").
  do_consulting.
  
  goes(MyGoal):-
    clear, nl,  
    write("To start enter 'Camera'"), nl,
    readln(Mygoal).
  
  inpo(Rno, Bno, Text):-
    write("Question! Is your camera: ", Text, "?"),nl,
    write("\tFor 'yes' type 1 : "), nl,
    write("\tFor 'no' type 2 : "), nl,
    readint(Response),
    do_answer(Rno, Text, Bno, Response).
    
  eval_reply('y'):-
    write("Enjoy it! ").
  eval_reply('n'):-
    write("I tried my best :( ").
    
  go(Mygoal):-
    NOT(rule(_, Mygoal, _, _)), !, nl,
    write("Camera you have chosen is a ", Mygoal, "."), nl,
    write("Would you like to buy it? (y/n) "), nl,
    readchar(R),
    eval_reply(R).
  go(Mygoal):-
    rule(Rno, Mygoal, Ny, Cond),
    check(Rno, Cond),
    go(Ny).
  
  check(Rno, [Bno|Rest]):-
    yes(Bno), !,
    check(Rno, Rest).
  check(_, [Bno|_]):-
    no(Bno), !, fail.
  check(Rno, [Bno|Rest]):-
    cond(Bno, Text), 
    inpo(Rno, Bno, Text),
    check(Rno, Rest).
  check(_, []).
  
  do_answer(_, _, _, 0):-
    exit.
  do_answer(_, _, Bno, 1):-
    assert(yes(Bno)),
    write("yes"), nl.
  do_answer(_, _, Bno, 2):-
    assert(no(Bno)),
    write("yes"), nl, fail.
  
  clear:-
    retract(yes(_)), fail;
    retract(no(_)), fail;
    !.
    
GOAL
  write ("Visual Prolog 5.2 lab made by Egor Shadrin in agony and pain"),nl,
  consult("C:\\Users\\egor_\\Documents\\prolog_lab\\base.dba", all_rules),
  show_menu.