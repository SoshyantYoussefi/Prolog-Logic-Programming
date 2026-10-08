

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


intersection(Xs, [], []).
intersection([], Ys, []).

intersection([X | Xs], [X| Ys], [X|R]):-
    intersection(Xs, Ys, R).

intersection([X | Xs], [Y| Ys], R):-
    X@<Y, %prologs egna ordning
    intersection(Xs, [Y|Ys], R).

intersection([X | Xs], [Y| Ys], R):-
    X@>Y, %prologs egna ordning
    intersection([X|Xs], Ys, R).



%powerset([], [[]]).

%skapar delmängderna
subset_gen([], []).

subset_gen([X|Xs], [X|Ys]) :-
    subset_gen(Xs, Ys).

subset_gen([_|Xs], Ys) :-
    subset_gen(Xs, Ys).

% Sätter in elementen i lista
insert_term(X, [], [X]).

insert_term(X, [Y|Ys], [X,Y|Ys]) :-
    X @< Y.

insert_term(X, [X|Ys], [X|Ys]).

insert_term(X, [Y|Ys], [Y|Zs]) :-
    X @> Y,
    insert_term(X, Ys, Zs).

% Egen sortering
sort_terms([], []).

sort_terms([X|Xs], Sorted) :-
    sort_terms(Xs, SortedTail),
    insert_term(X, SortedTail, Sorted).


% Powerset
powerset(Set, PowerSet) :-
    % findall(Template, Goal, List) Kör goal och samlar lösningarna i template, dessa lösningar sparas sedn i unsorted
    findall(SubSet, subset_gen(Set, SubSet), Unsorted), 
    sort_terms(Unsorted, PowerSet).
