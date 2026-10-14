%Tabulation enligt labbinstruktioner
:- table dfs(_, first).

%Om vi har nått målet är sökningen kla
dfs(State, [State]) :-
    goal_state(State).

%behövs loop detection ty rekursionen kan hoppa fram o tillbaka mellan samma tillstånd.
dfs(State, [State | Path] ) :- 
    next(State, NewState),
    dfs(NewState, Path).

%Kontrollerar ifall en sida är safe 
safe(0,_).
safe(K,B):-
    K>0,
    K>=B.

%Kontrollerar ifall BÅDA sidorna är safe 
safe(state(K, B, _)):-
    between(0, 3, K),
    between(0, 3, B),
    safe(K, B),
    KR is 3 - K,
    BR is 3 - B,
   safe(KR, BR).

%beskriver hur båten kan fröflryttas: transport(knight, brigand) alla möjliga kombinationer
transport(1,0).
transport(0,1).
transport(2,0). 
transport(0,2).
transport(1,1).

% status(nuvarante tillstånd, nästa tillstånd) från vänster till höger
next(state(K, B, left), state(K2, B2, right)):-
    transport(KK, BB),
    K2 is K - KK,
    B2 is B - BB,
    safe(state(K2,B2,right)).

% status(nuvarante tillstånd, nästa tillstånd) från höger itll vänster
next(state(K, B, right), state(K2, B2, left)):-
    transport(KK, BB),
    K2 is K + KK,
    B2 is B + BB,
    safe(state(K2,B2,left)).
/*
goal_state(c).
start_state(a).
next(a,b).
next(b,a).
next(b,c).
*/

% Alla börjar på vänster sida
start_state(state(3, 3, left)).

% Alla ska till höger sida
goal_state(state(0, 0, right)).
%Testa:
% start_state(S), dfs(S, Path).