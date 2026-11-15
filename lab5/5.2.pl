
/*
  TDDD08 - Lab 5
  Exercise 5.2 - Warm-up

  Each man can be either a bachelor
  or a husband.
*/

man(dilbert).
man(wally).

bachelor(X) :-
    man(X),
    not husband(X).

husband(X) :-
    man(X),
    not bachelor(X).
