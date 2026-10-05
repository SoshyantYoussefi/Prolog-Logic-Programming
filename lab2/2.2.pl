% middle(X,Xs)
% X is the middle element in the list Xs

/*
middle(X, [X]).
middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).

%?- middle(X, [a,b,c]) => X = b 
% ?- middle(a, X). => X = [a] 


%append efter
middle(X, [X]).
middle(X, [First|Xs]) :-
    middle(X, Middle),
    append(Middle, [Last], Xs).
%?- middle(X, [a,b,c]) => X = b 
% ?- middle(a, X). => X = [a] 



%Basfall efter
middle(X, [First|Xs]) :-
    append(Middle, [Last], Xs),
    middle(X, Middle).
middle(X, [X]).

%?- middle(X, [a,b,c]) => X = b 
% ?- middle(a, X). => X = [_, a, _] 
*/
%Basfall efter
middle(X, [First|Xs]) :-
    middle(X, Middle),
    append(Middle, [Last], Xs).
middle(X, [X]).

%?- middle(X, [a,b,c]) => oändlig loop
% ?- middle(a, X). => X = oändlig loop


