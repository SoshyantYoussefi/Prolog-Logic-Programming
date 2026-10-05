% Uppercase = variable, lowercase = constant
%[] tom lista, [X|Xs] = [Head, Sec|Tail]

%member(X, List) betyder: Är X ett element i List?
%append/3 - append([1,2], [3,4], X) - X = [1,2,3,4].
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
list_transform(L, [X | Rest]):-
    hitta_minsta(L, X),
    append(Left, [X| Right], L),
    append(Left, Right, Rest).

ssort([], []).
%L1 = [X| Tail]
ssort(L, [Minsta| SlutTail]):-
    list_transform(L, [Minsta| Tail]),
    ssort(Tail, SlutTail).

%Quick sort
larger(N, [], []).
larger(N, [X| Tail], [X| Tail2]):-
    N =< X,
    larger(N, Tail, Tail2).
%Ifall X inte är larger blir resultatet samma lista exklusive X
larger(N, [X| Tail], Tail2):-
    N > X,
    larger(N, Tail, Tail2).

smaller(N, [], []).
smaller(N, [X| Tail], [X| Tail2]):-
    N > X,
    smaller(N, Tail, Tail2).

%Ifall X inte är smaller blir resultatet samma lista exklusive X
smaller(N, [X| Tail], Tail2):-
    N =< X,
    smaller(N, Tail, Tail2).

qsort([], []).
qsort([N| Tail], Sorted):-
    larger(N, Tail, Larger),
    smaller(N, Tail, Smaller),
    qsort(Larger, Larger2),
    qsort(Smaller, Smaller2),
    append(Smaller2, [N| Larger2], Sorted).



    


