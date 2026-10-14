
% Basfall: Vi har nått målet
bfs([Node|_], Node) :-
    last(Node, State),
    goal_state(State).

% Om målet är hittat, fortsätt söka i resten av kön
bfs([Node|Rutt], Losning) :-
    last(Node, State),
    goal_state(State),
    bfs(Rutt, Losning).

%Inte nått förtsätt sökningen
bfs([Node|Rutt], Losning):- 
    last(Node, State), %last plockar ut sista noden
    goal_state(Goal),
    dif(State, Goal),
    findall(NyttTillstånd, next(State, NyttTillstånd ), NyaTillstånd),
%Läggar alla möjliga nyatillstånd i NyaTillstånd, OBS inkl. den vi redan besökt
    tillagg(Node, NyaTillstånd, NyaRutter),
    append(Rutt, NyaRutter, NyKo), %Lägger de nya vägarna sist i kön. NyKö
    bfs(NyKo, Losning).
    
% Node = [a,b] och NyaTillsåtnd = [c,d] gör att vi vill ha NyaVägar = [[a,b,c], [a,b,d]]
% Lägger till tillståndet om det inte redan finns i vägen
tillagg(_, [], []).
tillagg(Node, [NyttTillstånd|Resten], [NyRutt|NyaRutter]) :-
    ej_visited(NyttTillstånd, Node),
    append(Node, [NyttTillstånd], NyRutt), % Node = [a,b] NyttTillstånd = c får vi NyRutt = [a,b,c]
    tillagg(Node, Resten, NyaRutter).


% Hoppa över tillståndet om det redan finns i vägen
tillagg(Node, [NyttTillstånd|Resten], NyaRutter) :-
    member(NyttTillstånd, Node),
    tillagg(Node, Resten, NyaRutter).

% Kontrollerar att X inte finns i listan Förhindrar loop
ej_visited(_, []).
ej_visited(X, [Y|Resten]) :-
    dif(X, Y),
    ej_visited(X, Resten).


% start_state(S), bfs([[S]], Losning).