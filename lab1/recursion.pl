%Lärdomar: Uppercase = variable, Lowercase = constant

edge(a,b).
edge(a,c).
edge(b,c).
edge(c,d).
edge(d,h).
edge(c,e).
edge(e,f).
edge(e,g).
edge(d,f).
edge(f,g).

path(X,Y):-
    edge(X,Y).
    
path(X, Y):-
    edge(X,Z),
    path(Z,Y).

%path(start, finish, vägen head|tail)

path(X,Y,[X,Y]):-
    edge(X,Y).  

path(X,Y,[X|Tail]):-
    edge(X,Z),
    path(Z,Y, Tail).

npath(X,Y, L):-
    path(X,Y, Path),
    length(Path, L).

%npath(X, Y, L):-
    path(X, Y, [_|Tail]),
    length(Tail, L).


