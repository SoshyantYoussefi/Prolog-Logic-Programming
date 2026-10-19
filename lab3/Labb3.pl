- ensure_loaded('scanner.pl').
:- ensure_loaded('lab2_3.pl').

run(In, String, Out) :-
    scan(String, Tokens),
    parse(Tokens, AST),
    execute(In, AST, Out).

% LAB 3.1 - PARSER

% Tokens = listan med ord och symboler som ska läsas.
% AST = resultatet, alltså programmets struktur.
% phrase/2 kör grammatiken pgm på hela tokenlistan.
parse(Tokens, AST) :-
    phrase(pgm(AST), Tokens).

% PROGRAM
% Om vi har flera kommandon med ; emellan.
% C1 är första kommandot och C2 är resten av programmet.
pgm(seq(C1, C2)) -->
    cmd(C1),
    [';'],
    pgm(C2).

pgm(C) --> cmd(C).

% Test: parse([skip,';',skip], X).
% X = seq(skip,skip).

% KOMMANDON

% Skip
cmd(skip) -->
    [skip].

% Variabel tilldelning: x := 5
cmd(set(I, E)) -->
    [id(I)],
    [':='],
    expr(E).

% If annars else
cmd(if(B, C1, C2)) -->
    [if],
    bool(B),
    [then],
    pgm(C1),
    [else],
    pgm(C2),
    [fi].

% Test: parse([if,tt,then,skip,else,skip,fi], X).

% While loop
cmd(while(B, C)) -->
    [while],
    bool(B),
    [do],
    pgm(C),
    [od].

% TOLKA BOOLS

bool(tt) -->
    [tt].

bool(ff) -->
    [ff].

bool(tt) -->
    [true].

bool(ff) -->
    [false].

bool(E1 > E2) -->
    expr(E1),
    ['>'],
    expr(E2).

bool(E1 < E2) -->
    expr(E1),
    ['<'],
    expr(E2).

% Matte utryck

% Add
expr(E1 + E2) -->
    factor(E1),
    ['+'],
    expr(E2).

% Sub
expr(E1 - E2) -->
    factor(E1),
    ['-'],
    expr(E2).

% En faktor
expr(E) -->
    factor(E).

% Mult
factor(E1 * E2) -->
    term(E1),
    ['*'],
    factor(E2).

factor(E) -->
    term(E).

% En term som varible
term(id(I)) -->
    [id(I)].

term(num(N)) -->
    [num(N)].

    % TESTA HELA PROGRAMMET

% Enkel tilldelning:
% parse([id(x),':=',num(5)], X).

% Flera kommandon:
% parse([id(x),':=',num(5),';',skip], X).

% Addition och multiplikation:
% parse([id(x),':=',num(2),'+',num(3),'*',num(4)], X).

% Enkel while:
% parse([while,ff,do,skip,od], X).
