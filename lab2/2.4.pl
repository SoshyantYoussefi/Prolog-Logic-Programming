%Fall: samma element, andra större än första, andra mindre än första.

% union/3 - Slår ihop två sorterade mängder utan dubbletter.
union(Xs, [], Xs).
union([], Ys, Ys).


union([X | Xs], [X| Ys], [X|R]):-
    union(Xs, Ys, R).

union([X | Xs], [Y| Ys], [X|R]):-
    X@<Y, %prologs egna ordning
    union(Xs, [Y|Ys], R).

union([X | Xs], [Y| Ys], [Y|R]):-
    X@>Y,
    union([X|Xs], Ys, R).

% intersection/3 - Hittar gemensamma element i två sorterade mängder.
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
% subset_gen/2 - Genererar delmängder av en lista.
%skapar delmängderna
subset_gen([], []).

subset_gen([X|Xs], [X|Ys]) :-
    subset_gen(Xs, Ys).

subset_gen([_|Xs], Ys) :-
    subset_gen(Xs, Ys).


%insert_term/3 - Sätter in elementen i lista
insert_term(X, [], [X]).

insert_term(X, [Y|Ys], [X,Y|Ys]) :-
    X @< Y.

insert_term(X, [X|Ys], [X|Ys]).

insert_term(X, [Y|Ys], [Y|Zs]) :-
    X @> Y,
    insert_term(X, Ys, Zs).


%sort_terms/2 - Sorterar en lista enligt  standardordningen, tar bort dubbletter.
sort_terms([], []).

sort_terms([X|Xs], Sorted) :-
    sort_terms(Xs, SortedTail),
    insert_term(X, SortedTail, Sorted).


%  powerset/2 - Skapar mängden av alla delmängder och sorterar dem.
powerset(Set, PowerSet) :-
    % findall(Template, Goal, List) Kör goal och samlar lösningarna i template, dessa lösningar sparas sedn i unsorted
    findall(SubSet, subset_gen(Set, SubSet), Unsorted), 
    sort_terms(Unsorted, PowerSet).



%testfalll
% ?- union([1,3,5], [2,3,4], R).           R = [1,2,3,4,5]
% ?- union([], [1,2], R).                  R = [1,2]
% ?- intersection([1,2,3], [2,3,4], R).    R = [2,3]
% ?- intersection([1,2], [3,4], R).        R = []
% ?- subset_gen([1,2], R).                R = [1,2]; [1]; [2]; []
% ?- insert_term(2, [1,3], R).            R = [1,2,3]
% ?- sort_terms([3,1,2], R).              R = [1,2,3]
% ?- powerset([1,2], R).                  R = [[],[1],[1,2],[2]]