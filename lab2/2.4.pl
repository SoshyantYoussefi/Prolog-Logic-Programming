

%Fall: samma element, andra större än första, andra mindre än första.

union(Xs, [], Xs).
union([], Ys, Ys).

union([X | Xs], [X| Ys], [X|R]):-
    union(Xs, Ys, R).

union([X | Xs], [Y| Ys], [X|R]):-
    X@<Y, %prologs egna ordning
    union(Xs, [Y|Ys], R).

union([X | Xs], [Y| Ys], [X|R]):-
    X@>Y,
    union([X|Xs], Ys, R).







intersection():-


powerset():-
