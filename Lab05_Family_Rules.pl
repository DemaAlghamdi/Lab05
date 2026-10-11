% The Simpsons Family Knowledge Base

% FACTS
male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).
male(ling).

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).

parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).


% Rules

father(X, Y) :-
    parent(X, Y),
    male(X).

mother(X, Y) :-
    parent(X, Y),
    female(X).

son(X, Y) :-
    parent(Y, X),
    male(X).

daughter(X, Y) :-
    parent(Y, X),
    female(X).

brother(X, Y) :-
    parent(P, X),
    parent(P, Y),
    male(X),
    X \= Y.

sister(X, Y) :-
    parent(P, X),
    parent(P, Y),
    female(X),
    X \= Y.

grandfather(X, Y) :-
    parent(X, Z),
    parent(Z, Y),
    male(X).

aunt(X, Y) :-
    sister(X, P),
    parent(P, Y).

uncle(X, Y) :-
    brother(X, P),
    parent(P, Y).

cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    (brother(P1, P2); sister(P1, P2)),
    X \= Y.

% Ancestor - Base case
ancestor(X, Y) :-
    parent(X, Y).

% Ancestor - Recursive case
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).


% ==================================================

% Test Queries and Results:

% FATHER
% 1. ?- father(X, bart).
%    X = homer.
% 2. ?- father(clancy, X).
%    X = marge ; X = patty ; X = selma.

% MOTHER
% 3. ?- mother(X, ling).
%    X = selma.
% 4. ?- mother(marge, X).
%    X = bart ; X = lisa ; X = maggie.

% SON
% 5. ?- son(X, marge).
%    X = bart.
% 6. ?- son(X, abraham).
%    X = herb ; X = homer.

% DAUGHTER
% 7. ?- daughter(X, homer).
%    X = lisa ; X = maggie.
% 8. ?- daughter(ling, X).
%    X = selma.

% BROTHER
% 9. ?- brother(X, herb).
%    X = homer.
% 10. ?- brother(bart, X).
%     X = lisa ; X = maggie.

% SISTER
% 11. ?- sister(X, marge).
%     X = patty ; X = selma.
% 12. ?- sister(lisa, X).
%     X = bart ; X = maggie.

% GRANDFATHER
% 13. ?- grandfather(X, bart).
%     X = abraham ; X = clancy.
% 14. ?- grandfather(clancy, X).
%     X = bart ; X = lisa ; X = maggie.

% AUNT
% 15. ?- aunt(X, bart).
%     X = patty ; X = selma.
% 16. ?- aunt(patty, X).
%     X = bart ; X = lisa ; X = maggie.

% UNCLE
% 17. ?- uncle(X, lisa).
%     X = herb.
% 18. ?- uncle(herb, X).
%     X = bart ; X = lisa ; X = maggie.

% COUSIN
% 19. ?- cousin(X, ling).
%     X = bart ; X = lisa ; X = maggie.
% 20. ?- cousin(bart, X).
%     X = ling.

% ANCESTOR (recursive rule)
% 21. ?- ancestor(X, ling).
%     X = selma ; X = clancy ; X = jackie.
% 22. ?- ancestor(abraham, X).
%     X = herb ; X = homer ; X = bart ; X = lisa ; X = maggie.
