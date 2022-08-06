%min/max helper functions from class notes
min(X, Y, X) :- X =< Y.                             
min(X, Y, Y) :- X > Y.

max(X, Y, X) :- X >= Y.                            
max(X, Y, Y) :- X < Y.

%-------------------------------------1-------------------------------------
fill(0, _, []).                                     %base case
fill(N, X, [X|Rest]) :-                             %recursive case
    N > 0,
    Ns is N-1,
    fill(Ns, X, Rest).

%-------------------------------------2-------------------------------------
numlist2(Lo, Hi, Result) :-
    Lo =< Hi,                                       % is Lo less than or equal to Hi
    numlist2(Lo, Hi, Result).

%-------------------------------------3-------------------------------------
minmax([X], X, X).                                  % base case 
minmax([Head|Rest], Min, Max):-                     % recursive call
    minmax(Rest, Mins, Maxs),
    Min is min(Head, Mins),
    Max is max(Head, Maxs).

%-------------------------------------4-------------------------------------
negpos(Lst, Lsts, Lsts1) :-                  
    msort(Lst, NewLst),                             %returning negpos sorted
    negposS(NewLst, Lsts, Lsts1).

negposS([], [], []).                                %base case
negposS([X|Rest], [X|RestN], Y) :-                  %case 1
    X < 0,
    negposS(Rest, RestN, Y).
negposS([X|Rest], Z, [X|RestS]) :-                  %case 2
    X >= 0,
    negposS(Rest, Z, RestS).

%-------------------------------------5-------------------------------------
%derived from class notes
alpha([T, I, M, B, Y, U], Tim, Bit, Yumyum) :-
    between(1, 9, T),                               %cannot be 0
    between(0, 9, I), T \= I,                       %don't unify
    between(0, 9, M), \+ member(M, [T, I]),         %check if M is member .... 
    between(1, 9, B), \+ member(B, [T, I, M]),      % cannot be 0
    between(1, 9, Y), \+ member(Y, [T, I, M, B]),   % cannot be 0   
    between(0, 9, U), \+ member(U, [T, I, M, B, Y]),
    Tim is T*100 + I*10 + M,                        %Base 10
    Bit is B*100 + I*10 + T,
    Yumyum is Y*100000 + U*10000 + M*1000 + Y*100 + U*10 + M,
    Yumyum is Tim * Bit.

%-------------------------------------6-------------------------------------
 magic([X1, X2, X3, X4, X5, X6, X7, X8, X9], [A, A1, A2, B, B1, B2, C, C1, C2], N) :-
    permutation([X1, X2, X3, X4, X5, X6, X7, X8, X9],[A, A1, A2, B, B1, B2, C, C1, C2]),
    Row1 is A + A1 + A2,
    Row2 is B + B1 + B2,
    Row3 is C + C1 + C2,
    Col1 is A + B + C,
    Col2 is A1 + B1 + C1,
    Col3 is A2 + B2 + C2,

    N is A + A1 + A2,                               % N is based off the first row, since they all equate

    Row1 == Row2,
    Row1 == Row3,
    Row1 == Col1,
    Row1 == Col2,
    Row1 == Col3.
