:- use_module(library(sldnfdraw)).
:- sldnf.

:- begin_program.

middle(X, [X]).

middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).

:- end_program.

:- begin_query.

middle(X, [a,b,c]).

:- end_query.