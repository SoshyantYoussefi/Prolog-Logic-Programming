 %I - Identifiers, x,y,z
%N - Natural numbers 1,2,3,4
%
%

%Memory
get([X=Value | _], X, Value). % Första fallet är när X är först i listan.
get([Y = _ | Tail], X, Value):-
    dif(X,Y), %x har olika värden
    get(Tail, X, Value).


% set([x=3, y=7], x, 10, B2). Sätt x till 10 B2 är nya minnet, första argumentet är gamla minnet.
set([], X, Value, [X=Value]).
set([X=_ | Tail], X, Value, [X = Value| Tail]). % Första fallet är att värdet vi vill ändra är först i listan.
set([Y = Old | Tail], X, Value, [Y = Old| NewTail]):-
    dif(X,Y), %x har olika värden
    set(Tail, X, Value, NewTail).
    

%aritmetik
%Basfall för num/id
eval(_, num(N), N).
eval(M, id(X), Value):-
    get(M, X, Value).
%Evaluate med index adderat med tal, ex x + 3

%Addition
eval(M, T1 + T2, Value):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value is Value1 + Value2.

%Subtratkion
eval(M, T1 - T2, Value):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value is Value1 - Value2.

%Multiplikation
eval(M, T1 * T2, Value):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value is Value1 * Value2.


%boolska uttryck
true_(_, tt).
false(_, ff).


true_(M, T1 < T2):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value1 < Value2.

false(M, T1 < T2):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value1 >= Value2.

true_(M, T1 > T2):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value1 > Value2.

false(M, T1 > T2):-
    eval(M, T1, Value1),
    eval(M, T2, Value2),
    Value1 =< Value2.


%(Startminne, Program, Slutminne)
%skip
execute(S0, skip, S0).

%set
execute(S0, set(I,E), Sn):-
    eval(S0, E, Value),
    set(S0, I, Value, Sn).

%seq
execute(S0, seq(C1,C2), Sn2):-
    execute(S0, C1, Sn),
    execute(Sn, C2, Sn2).


%if
execute(S0, if(B,C,_), Sn):-
    true_(S0, B),
    execute(S0, C, Sn).

execute(S0, if(B,_,C), Sn):-
    false(S0, B),
    execute(S0, C, Sn).


%While
execute(S0, while(B,C), Sn2):-  
    true_(S0, B),
    execute(S0, C, Sn),
    execute(Sn, while(B,C), Sn2).

execute(S0, while(B,C), S0):-
    false(S0, B).