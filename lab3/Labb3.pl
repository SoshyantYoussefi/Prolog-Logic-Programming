% LAB 3.1 - PARSER

% parse(Tokens, AST)
% Converts tokens into abstract syntax.
parse(Tokens, AST) :-
    phrase(pgm(AST), Tokens).

% PROGRAM
% A program consists of one or more commands.

pgm(seq(C1, C2)) -->
    cmd(C1),
    [';'],
    pgm(C2).

pgm(C) -->
    cmd(C).

% COMMANDS

% Skip
cmd(skip) -->
    [skip].

% Assignment: x := 5
cmd(set(I, E)) -->
    [id(I)],
    [':='],
    expr(E).

% If-then-else
cmd(if(B, C1, C2)) -->
    [if],
    bool(B),
    [then],
    pgm(C1),
    [else],
    pgm(C2),
    [fi].

% While loop
cmd(while(B, C)) -->
    [while],
    bool(B),
    [do],
    pgm(C),
    [od].

% BOOLEAN EXPRESSIONS

bool(tt) -->
    [tt].

bool(ff) -->
    [ff].

bool(E1 > E2) -->
    expr(E1),
    ['>'],
    expr(E2).

bool(E1 < E2) -->
    expr(E1),
    ['<'],
    expr(E2).

% ARITHMETIC EXPRESSIONS

% Addition
expr(E1 + E2) -->
    factor(E1),
    ['+'],
    expr(E2).

% Subtraction
expr(E1 - E2) -->
    factor(E1),
    ['-'],
    expr(E2).

% A single factor
expr(E) -->
    factor(E).

% FACTORS

% Multiplication
factor(E1 * E2) -->
    term(E1),
    ['*'],
    factor(E2).

% A single term
factor(E) -->
    term(E).

% TERMS

% Identifier
term(id(I)) -->
    [id(I)].

% Number
term(num(N)) -->
    [num(N)].
