%%%% Print the value of the board at index N:
% if its a variable, print ? and b or n otherwise.
printVal(N) :- board(B), nth0(N,B,Val), var(Val), write(' - '), !.
printVal(N) :- board(B), nth0(N,B,Val), Val=='B',write(' O ').
printVal(N) :- board(B), nth0(N,B,Val), Val=='N',write(' X ').


copyBoard(_,_,-1):-!.
copyBoard(Board,NewBoard,I):-nth0(I,Board,Player),nonvar(Player),nth0(I,NewBoard,Player),NextI is I-1,copyBoard(Board,NewBoard,NextI).
copyBoard(Board,NewBoard,I):-nth0(I,Board,Player),var(Player),NextI is I-1,copyBoard(Board,NewBoard,NextI).
%%%% Print all the values of a list

printValOfList(L,0) :- nth0(0,L,Val), writeln(Val).
printValOfList(L,N) :- nth0(N,L,Val), writeln(Val), Next is N-1, printValOfList(L,Next).

len([],0).
len([_|Y],R) :- len(Y,A),R is A+1.
printListVal(L,0) :- nth0(0,L,Val), writeln(Val),!.
printListVal(L,N) :- nth0(N,L,Val), writeln(Val), Next is N-1, printListVal(L,Next).
printList(L):-len(L,Len),I is Len-1,printListVal(L,I).
element(1,I,[I|_]).
element(R,I,[_|Y]) :- element(A,I,Y),R is A+1.
list2ens([],[]).
list2ens([X|Y],A) :- member(X,Y),list2ens(Y,A), !. %nous avons déja codé member!
list2ens([X|Y],[X|A]) :- list2ens(Y,A).


%test if a slot of the board is empty%
isPosEmpty(Board,Pos):-nth0(Pos,Board,Elem),var(Elem).
%test if a slot of the board belongs to the Player%
isPosNotBelong(Board,_,Pos):-isPosEmpty(Board,Pos).
isPosNotBelong(Board,Player,Pos):-nth0(Pos,Board,Elem),nonvar(Elem),Elem\==Player.
%test if a slot belongs to the Player%
isPosBelong(Board,Player,Pos):-nth0(Pos,Board,Elem),nonvar(Elem),Elem==Player.