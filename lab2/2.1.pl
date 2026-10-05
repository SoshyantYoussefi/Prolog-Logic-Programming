% Uppercase = variable, Lowercase = constant
%[] tom lista, [X|Xs] = [Head, Sec|Tail]


%Träd: base: l(X), t(L,R)

% peano-tal: zero, s(N)


issorted([]).
issorted([X]).

issorted([X, Y | Tail]):-
    X =< Y,
    issorted([Y|Tail]).


%Hjälpfunktiion - Hittar minsta elementet i lista

hitta_minsta([X], X).
%Ifall första elementet i listan X är mindre eller lika stort som svansens misnta
hitta_minsta([X| Tail], Minsta):-
    hitta_minsta(Tail, Tail_Minsta),
    X =< Tail_Minsta,
    Minsta = X.

%Ifall första elementet i listan X är större än  svansens misnta element
hitta_minsta([X| Tail], Minsta):-
    hitta_minsta(Tail, Tail_Minsta),
    X > Tail_Minsta,
    Minsta = Tail_Minsta.




%Selection sort

ssort([], []).

ssort([X| Tail], L1):-
    hitta_minsta([X])






%Quick sort