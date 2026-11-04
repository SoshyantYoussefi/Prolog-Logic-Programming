% middle(X,Xs)
% X is the middle element in the list Xs

/*
middle(X, [X]).
middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).

%?- middle(X, [a,b,c]) => X = b 
% ?- middle(a, X). => X = [a], X = [_, a, _] ,X = [_, _, a, _, _] ,X = [_, _, _, a, _, _, _] 
%Först vlir basfallet true men efteråt säker den sig rekursivt vidare och allt stämmer ty a kan vara i mitten i vilken lista som helst.


%append efter
middle(X, [X]).
middle(X, [First|Xs]) :-
    middle(X, Middle),
    append(Middle, [Last], Xs).

%?- middle(X, [a,b,c]) => X = b => o'ndligt
% ?- middle(a, X). => X = [a], X = [_, a, _], X = [_, _, a, _, _]  


%Basfall efter
middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).
middle(X, [X]).

%?- middle(X, [a,b,c]) => X = b, false 
% ?- middle(a, X). => X = [_, a, _] 
*/

%Basfall efter
middle(X, [First|Xs]) :-
    middle(X, Middle),
    append(Middle, [Last], Xs).
middle(X, [X]).

%?- middle(X, [a,b,c]) => oändlig loop
% ?- middle(a, X). => X = oändlig loop



/*

Version 1 (Base first, append first): Terminates for a given list because append reduces the list before recursion. Can also generate lists with a given middle element.

Version 3 (Base first, middle first): Finds the middle element but enters infinite recursion when searching for more solutions. Can generate lists with a given middle element.

Version 2 (Recursive first, append first): Terminates for a given list. For list generation, it produces longer lists but never reaches the base case as a standalone solution.

Version 4 (Recursive first, middle first): Enters infinite recursion for both queries because recursion happens before reaching the base case.

Preferred versions: Version 1 for middle(X,[a,b,c]) and Version 3 for middle(a,X).