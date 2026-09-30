%Lärdomar: Uppercase = variable, Lowercase = constant
dog(rex).
dog(fido).
dog(rover).

%%Anna is gentle
gentle(anna).

%Rex is gentle and well-fed
gentle(rex).
wellfed(rex).

%Erik is well-fed and energetic
wellfed(erik).
energetic(erik).

%Fido is energetic and gentle
energetic(fido).
gentle(fido).

%Rover is playful and energetic
playful(rover).
energetic(rover).

%Every dog trusts gentle people
trusts(D,P) :-
    dog(D),
    gentle(P). 

%All well-fed beings are content
content(B) :-
    wellfed(B).

%Every dog that trusts a person who trusts it back is content
content(D) :-
    trusts(D,P),
    trusts(P,D).

%Every person who trusts a dog that trusts them back is content
content(P) :-
    trusts(P,D),
    trusts(D,P).

%Rex trusts all people who trust Rex
trusts(rex, P) :-
    trusts(P,rex).

%Fido trusts everyone who is playful
trusts(fido, P) :-
    playful(P).

% Anna trusts all dogs that trust her, provided they are either (1) well-fed
% and playful, or (2) gentle and energetic */
