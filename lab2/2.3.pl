%I - Identifiers, x,y,z
%N - Natural numbers 1,2,3,4
%
%

%Memory
get([X=Value | _], X, Value). % Första fallet är när X är först i listan.
get([Y = _ | Tail], X, Value):-
    dif(X,Y), %x har olika värden
    get(Tail, X, Value).



set([X=Value | Tail], X, Value, [X = Value| Tail]). % Första fallet är att värdet vi vill ändra är först i listan.
set([Y = Old | Tail], X, Value, [X = Old| NewTail]):-
    dif(X,Y), %x har olika värden
    set(Tail, X, Value, NewTail).
    



%aritmetik
eval()


%boolska uttryck
true_bool()
false_bool()

%Kommandon
execute(S0, P, Sn):-
    .