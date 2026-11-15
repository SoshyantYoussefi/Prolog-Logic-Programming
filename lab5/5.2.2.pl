included(X) :-
    node(X),
    not excluded(X).

excluded(X) :-
    node(X),
    not included(X).


% Equality relation.

equal(X, X) :-
    node(X).


% Check if at least three distinct nodes
% are included in the selected set.

three_or_more :-
    included(X),
    included(Y),
    included(Z),
    not equal(X, Y),
    not equal(Y, Z),
    not equal(X, Z).


% Reject sets containing fewer than three nodes.

:- not three_or_more.


% Reject sets where two distinct included
% nodes are not connected by an edge.

:- included(X),
   included(Y),
   not equal(X, Y),
   not edge(X, Y).
