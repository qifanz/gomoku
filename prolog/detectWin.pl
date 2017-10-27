%%%% Test is the game is finished %%%
gameover(Winner,NewPos) :- board(Board), winner(Board,Winner,NewPos), !.  % There exists a winning configuration: We cut!
gameover('Draw',_) :- board(Board), isBoardFull(Board). % the Board is fully instanciated (no free variable): Draw.


%%%% Recursive predicate that checks if all the elements of the List (a board) 
%%%% are instanciated
isBoardFull([]).
isBoardFull([H|T]):- nonvar(H), isBoardFull(T).

%%%% Condition to detect the winner
%From the position of the current piece, decrement the Accumulator when a piece adjacent is of the same color, when the accumulator is decremented to 1, winner found.
%If the piece adjacent is not the same color and the accumulator is not yet 1, try to change the searching direction for one time.
%P: player NewPos: the position of the last piece.
winner(Board,Player,NewPos):-accmulator(Board,Player,NewPos,5).

accmulator(Board,Player,NewPos,Acc):-accRight(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accLeft(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accUp(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accDown(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accUpperRight(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accLowerLeft(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accUpperLeft(Board,Player,NewPos,Acc),!.
accmulator(Board,Player,NewPos,Acc):-accLowerRight(Board,Player,NewPos,Acc).




accRight(_,_,_,1).
accRight(Board,Player,NewPos,NewAcc):-
	Pos is NewPos+1,
	X is mod(Pos,15),X\==0,Acc is NewAcc-1,
	isPosBelong(Board,Player,Pos),
	accRight(Board,Player,Pos,Acc),!.
accRight(Board,Player,NewPos,_):-accLeft(Board,Player,NewPos,5).

accLeft(_,_,_,1).
accLeft(Board,Player,NewPos,NewAcc):-
    Pos is NewPos-1,
    X is mod(Pos,15),
    X\==14,Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLeft(Board,Player,Pos,Acc).

accUp(_,_,_,1).
accUp(Board,Player,NewPos,NewAcc):-
    Pos is NewPos-15,Pos>=0,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUp(Board,Player,Pos,Acc),!.
accUp(Board,Player,NewPos,_):-accDown(Board,Player,NewPos,5).

accDown(_,_,_,1).
accDown(Board,Player,NewPos,NewAcc):-
    Pos is NewPos+15,
    Pos<225,Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accDown(Board,Player,Pos,Acc).

accUpperRight(_,_,_,1).
accUpperRight(Board,Player,NewPos,NewAcc):-
    Pos is NewPos-14,
    X is mod(NewPos,15),
    X\==14,Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUpperRight(Board,Player,Pos,Acc),!.
accUpperRight(Board,Player,NewPos,_):-accLowerLeft(Board,Player,NewPos,5).

accLowerLeft(_,_,_,1).
accLowerLeft(Board,Player,NewPos,NewAcc):-
    Pos is NewPos+14,
    X is mod(NewPos,15),
    X\==0,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLowerLeft(Board,Player,Pos,Acc).

accUpperLeft(_,_,_,1).
accUpperLeft(Board,Player,NewPos,NewAcc):-
    Pos is NewPos-16,
    X is mod(NewPos,15),
    X\==0,Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUpperLeft(Board,Player,Pos,Acc),!.
accUpperLeft(Board,Player,NewPos,_):-accLowerRight(Board,Player,NewPos,5).

accLowerRight(_,_,_,1).
accLowerRight(Board,Player,NewPos,NewAcc):-
	Pos is NewPos+16,
    X is mod(NewPos,15),
    X\==14,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLowerRight(Board,Player,Pos,Acc).