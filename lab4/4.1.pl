
:- table dfs(_, first).

%Om vi har nått målet är sökningen klar. Path tillagt som i uppg1.2
dfs(State, [State]) :-
    goal_state(State).

%behövs loop detection ty rekursionen kan hoppa fram o tillbaka mellan samma tillstånd.
dfs(State, [State | Path] ) :- 
    next(State, NewState),
    dfs(NewState, Path).


goal_state(c).
start_state(a).
next(a,b).
next(b,a).
next(b,c).




