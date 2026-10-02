%[] tom lista, [X|Xs] = [Head, Sec|Tail]
% Uppercase = variable, Lowercase = constant

%Träd: base: l(X), t(L,R)

% peano-tal: zero, s(N)


issorted([]).
issorted([X]).

issorted([X, Y | Tail]):-
    X =< Y,
    issorted([Y|Tail]).
