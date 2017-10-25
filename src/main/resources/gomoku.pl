:- dynamic board/1.

%%%% Test is the game is finished %%%
gameover(Winner,NewPos) :- board(Board), winner(Board,Winner,NewPos), !.  % There exists a winning configuration: We cut!
gameover('Draw',_) :- board(Board), isBoardFull(Board). % the Board is fully instanciated (no free variable): Draw.

%%%% Condition to detect the winner
%From the position of the current piece, decrement the Accumulator when a piece adjacent is of the same color, when the accumulator is decremented to 1, winner found.
%If the piece adjacent is not the same color and the accumulator is not yet 1, try to change the searching direction for one time.
%P: player NewPos: the position of the last piece.
winner(Board,P,NewPos):-accRight(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accLeft(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accUp(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accDown(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accUpperRight(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accLowerLeft(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accUpperLeft(Board,P,NewPos,5),!.
winner(Board,P,NewPos):-accLowerRight(Board,P,NewPos,5).

accRight(_,_,_,1).
accRight(Board,P,NewPos,NewAcc):-Pos is NewPos+1,X is mod(Pos,15),X\==0,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accRight(Board,P,Pos,Acc),!.
accRight(Board,P,NewPos,_):-accLeft(Board,P,NewPos,5).

accLeft(_,_,_,1).
accLeft(Board,P,NewPos,NewAcc):-Pos is NewPos-1,X is mod(Pos,15),X\==14,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accLeft(Board,P,Pos,Acc).

accUp(_,_,_,1).
accUp(Board,P,NewPos,NewAcc):-Pos is NewPos-15,Pos>=0,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accUp(Board,P,Pos,Acc),!.
accUp(Board,P,NewPos,_):-accDown(Board,P,NewPos,5).

accDown(_,_,_,1).
accDown(Board,P,NewPos,NewAcc):-Pos is NewPos+15,Pos<225,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accDown(Board,P,Pos,Acc).

accUpperRight(_,_,_,1).
accUpperRight(Board,P,NewPos,NewAcc):-Pos is NewPos-14,X is mod(NewPos,15),X\==14,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accUpperRight(Board,P,Pos,Acc),!.
accUpperRight(Board,P,NewPos,_):-accLowerLeft(Board,P,NewPos,5).

accLowerLeft(_,_,_,1).
accLowerLeft(Board,P,NewPos,NewAcc):-Pos is NewPos+14,X is mod(NewPos,15),X\==0,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accLowerLeft(Board,P,Pos,Acc).

accUpperLeft(_,_,_,1).
accUpperLeft(Board,P,NewPos,NewAcc):-Pos is NewPos-16,X is mod(NewPos,15),X\==0,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accUpperLeft(Board,P,Pos,Acc),!.
accUpperLeft(Board,P,NewPos,_):-accLowerRight(Board,P,NewPos,5).

accLowerRight(_,_,_,1).
accLowerRight(Board,P,NewPos,NewAcc):-Pos is NewPos+16,X is mod(NewPos,15),X\==14,Acc is NewAcc-1,nth0(Pos,Board,Elem),nonvar(Elem),Elem==P,accLowerRight(Board,P,Pos,Acc).

%test if a slot of the board is empty%
isPosEmpty(Board,Pos):-nth0(Pos,Board,Elem),var(Elem).
%test if a slot of the board belongs to the Player%
isPosNotBelong(Board,_,Pos):-isPosEmpty(Board,Pos).
isPosNotBelong(Board,Player,Pos):-nth0(Pos,Board,Elem),nonvar(Elem),Elem\==Player.
%test if a slot belongs to the Player%
isPosBelong(Board,Player,Pos):-nth0(Pos,Board,Elem),nonvar(Elem),Elem==Player.
%%%Chercher les positions qui a au moins un voisin et les afficher.
%HasNeighbors: les positions qui a aumoins un voisin à 1 case à coté de lui.
%NextNeighbors: les positions qui a aumoins un voisin à 2 cases à coté de lui.
%Pour l'appeler: gererator(Board,224,HasNeighbors,NextNeighbors).
generator(_,0,[],[]).
generator(Board,P,[P|HasNeighbors],NextNeighbors):-hasNeighbors(Board,P),NextP is P-1,generator(Board,NextP,HasNeighbors,NextNeighbors),!.
generator(Board,P,HasNeighbors,[P|NextNeighbors]):-nextNeighbors(Board,P),NextP is P-1,generator(Board,NextP,HasNeighbors,NextNeighbors),!.
generator(Board,P,HasNeighbors,NextNeighbors):-NextP is P-1,generator(Board,NextP,HasNeighbors,NextNeighbors).



hasNeighbors(Board,P):-isPosEmpty(Board,P),X is mod(P,15),X\==14,Neighnor is P+1,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),X is mod(P,15),X\==0,Neighnor is P-1,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P < 210,Neighnor is P+15,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P > 14,Neighnor is P-15,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P > 15,X is mod(P,15),X\==0,Neighnor is P-16,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P < 209,X is mod(P,15),X\==14,Neighnor is P+16,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P > 13,X is mod(P,15),X\==14,Neighnor is P-14,\+isPosEmpty(Board,Neighnor).
hasNeighbors(Board,P):-isPosEmpty(Board,P),P < 211,X is mod(P,15),X\==0,Neighnor is P+14,\+isPosEmpty(Board,Neighnor).

nextNeighbors(Board,P):-isPosEmpty(Board,P),X is mod(P,15),X<13,Neighnor is P+2,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),X is mod(P,15),X>1,Neighnor is P-2,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 195,Neighnor is P+30,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 29,Neighnor is P-30,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 30,X is mod(P,15),X\==0,Neighnor is P-31,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 194,X is mod(P,15),X\==14,Neighnor is P+31,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 28,X is mod(P,15),X\==14,Neighnor is P-29,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 196,X is mod(P,15),X\==0,Neighnor is P+29,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 12,X is mod(P,15),X<13,Neighnor is P-13,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 212,X is mod(P,15),X>1,Neighnor is P+13,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 17,X is mod(P,15),X>1,Neighnor is P-17,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 208,X is mod(P,15),X<13,Neighnor is P+17,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 31,X is mod(P,15),X>1,Neighnor is P-32,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 193,X is mod(P,15),X<13,Neighnor is P+32,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P > 27,X is mod(P,15),X<13,Neighnor is P-28,\+isPosEmpty(Board,Neighnor).
nextNeighbors(Board,P):-isPosEmpty(Board,P),P < 197,X is mod(P,15),X>1,Neighnor is P+28,\+isPosEmpty(Board,Neighnor).



%%%The function of evaluation%%
%1st parameter: numbers of piece of same color continuosly
%2nd parameter: the number of piece(or border of the board) that blocks the row
%3rd parameter: the value evalutated corresponding to that situation
evaluateState(_,2,0):-!.
evaluateState(1,0,10):-!.
evaluateState(1,1,1):-!.
evaluateState(2,0,100):-!.
evaluateState(2,1,10):-!.
evaluateState(3,0,1000):-!.
evaluateState(3,1,100):-!.
evaluateState(3,0,1000):-!.
evaluateState(3,1,100):-!.
evaluateState(4,0,10000):-!.
evaluateState(4,1,1000):-!.
evaluateState(5,_,100000):-!.


%%%count the number of piece (or border of the board) that blocks the row
%Board: the board
%PosInit: the first piece continuous
%PosFinal: the last piece continuous
%3rd param: the number of blocks
%4th param:  value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
%increment=15 is a special case, thus we need to precise it.
countBlock(Board,PosInit,PosFinal,2,15):-Pos1 is PosInit-15,Pos1<0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,2,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2>224,\+isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,2,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(Board,PosInit,PosFinal,1,15):-Pos1 is PosInit-15,Pos1<0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,1,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2>224,isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,1,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,1,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(Board,PosInit,PosFinal,0,15):-Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.



countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>224,\+isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2<0,\+isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>224,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1<0,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,\+isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(_,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>224,!.
countBlock(_,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2<0,!.
countBlock(_,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>224,!.
countBlock(_,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1<0,!.
countBlock(Board,PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2<0,isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>224,isPosEmpty(Board,Pos1),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1<0,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>224,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(Board,PosInit,PosFinal,1,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.

countBlock(Board,PosInit,PosFinal,0,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.

%from a position, find the number of piece continous that are of the same color
%the last param is the value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
sameColorContinous(_,_,Pos,1,1):-X is mod(Pos,15),X==14,!.
sameColorContinous(_,_,Pos,1,15):-Pos>209,!.
sameColorContinous(_,_,Pos,1,16):-Pos>209,!.
sameColorContinous(_,_,Pos,1,16):-X is mod(Pos,15),X==14,!.
sameColorContinous(_,_,Pos,1,-14):-Pos<15,!.
sameColorContinous(_,_,Pos,1,-14):-X is mod(Pos,15),X==14,!.
sameColorContinous(Board,Player,Pos,1,Inc):-NextPos is Pos + Inc,isPosNotBelong(Board,Player,NextPos),!.
sameColorContinous(Board,Player,Pos,Acc,Inc):-NextPos is Pos + Inc,sameColorContinous(Board,Player,NextPos,NextAcc,Inc),Acc is NextAcc+1.

%evaluate the value of a serie of piece
evaluateSeries(Board,Player,Pos,PosFinal,Inc,Valeur):-sameColorContinous(Board,Player,Pos,Acc,Inc),PosFinal is Pos+(Acc-1)*Inc,countBlock(Board,Pos,PosFinal,NumBlock,Inc),evaluateState(Acc,NumBlock,Valeur).


%%%find the first position of the piece of the player
%firstElemOfPlayer(Player,PosInit,PosOfPlayer,Inc)
%PosOfPlayer is the value find, if no result found, return -1
%Inc is the value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,_):-nth0(Pos,Board,Elem),nonvar(Elem),Elem==Player,PosOfPlayer is Pos,!.
firstElemOfPlayer(_,_,Pos,-1,_):-Pos>224,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,16):-X is mod(Pos,15),X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,-14):-X is mod(Pos,15),X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,-14):-Pos<0,!. %Il n'y a plus de portion
firstElemOfPlayer(Board,Player,PosInit,PosOfPlayer,Inc):-NextPos is PosInit+Inc,firstElemOfPlayer(Board,Player,NextPos,PosOfPlayer,Inc).

%evaluate the score for a whole line(vertical, horizontal or diagonal)
%Inc is the value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
evaluateLine(Board,Player,Pos,Inc,0):-firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,Inc),PosOfPlayer<0,!.
evaluateLine(Board,Player,Pos,Inc,ValeurLine):-firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,Inc),PosOfPlayer>=0,evaluateSeries(Board,Player,PosOfPlayer,PosFinal,Inc,Valeur),NextPos is PosFinal+Inc,evaluateLine(Board,Player,NextPos,Inc,NextValeurLine),ValeurLine is NextValeurLine + Valeur.

% Pos [0,224]
evaluateLineHorizontalTotal(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,1,ValeurTotal).%

evaluateLineVerticalTotal(_,_,15,0):-!.
%% Pos [0,14]
evaluateLineVerticalTotal(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,15,ValeurLine),NextPos is Pos+1,evaluateLineVerticalTotal(Board,Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.


evaluateLineLowerRightTotal1(_,_,15,0):-!.
%% Pos [0,14]
evaluateLineLowerRightTotal1(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,16,ValeurLine),NextPos is Pos+1,evaluateLineLowerRightTotal1(Board,Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineLowerRightTotal2(_,_,225,0):-!.
%% Pos {15,30,45,...,210}
evaluateLineLowerRightTotal2(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,16,ValeurLine),NextPos is Pos+15,evaluateLineLowerRightTotal2(Board,Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal1(_,_,225,0):-!.
%% Pos {0,15,...210}
evaluateLineUpperRightTotal1(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,-14,ValeurLine),NextPos is Pos+15,evaluateLineUpperRightTotal1(Board,Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal2(_,_,225,0):-!.
%% Pos [211,224]
evaluateLineUpperRightTotal2(Board,Player,Pos,ValeurTotal):-evaluateLine(Board,Player,Pos,-14,ValeurLine),NextPos is Pos+1,evaluateLineUpperRightTotal2(Board,Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateTotalScore(Board,Player1,Valeur):-evaluatePlayer(Board,Player1,Valeur1),changePlayer(Player1,Player2),evaluatePlayer(Board,Player2,Valeur2),Valeur is Valeur1 -Valeur2.
evaluatePlayer(Board,Player,Valeur):-evaluateLineHorizontalTotal(Board,Player,0,Valeur1),evaluateLineVerticalTotal(Board,Player,0,Valeur2),evaluateLineLowerRightTotal1(Board,Player,0,Valeur3),evaluateLineLowerRightTotal2(Board,Player,15,Valeur4),evaluateLineUpperRightTotal1(Board,Player,0,Valeur5),evaluateLineUpperRightTotal2(Board,Player,211,Valeur6),Valeur is Valeur1+Valeur2+Valeur3+Valeur4+Valeur5+Valeur6.



%%%% Recursive predicate that checks if all the elements of the List (a board)
%%%% are instanciated
isBoardFull([]).
isBoardFull([H|T]):- nonvar(H), isBoardFull(T).

choice():-promptMode(X), X=='H',playHu('B',_),!.
choice():-choice2().

choice2():-promptMode2(X), X=='1',play('B',_),!.
choice2():-play('B',_).

human(Board, Move):-repeat, promptInput(R,C), Move is ((R-1)*15+C-1),nth0(Move, Board, Elem),var(Elem),!.
ia(Board, Index,_) :- repeat, Index is random(225-1), nth0(Index, Board, Elem), var(Elem), !.
ialocale(Board,Index,_):-repeat,!.

%iaMiniMax(Board, Index):-.


%Maximum depth of tree exploration.
    %prof_max(2).

%Optimal move computation.
%MiniMax(J, P, Coup, Eval):-coups_possibles(Liste_coups),
%    	((prof_max(P); Liste_coups == []) -> eval_plateau(J, Eval);
%        boucle(Liste_coups, P, J, Evalmax , Coupmax),
%       Coup = Coupmax,
%      Eval = Evalmax
%     ).

%recursivity( [] , _ , _ , _ , _ ).
%Stoping recursivity
%recursivity([Courant|Liste_coups], P, J, Evalmax, Coupmax):-choisir_joueur(P, J, Jo),
%    	jouer_coup(Courant, Jo),
%		P2 is P + 1,
%    	minimax(J, P2, Tmpcoup, Tmpeval),
%    	comparaison(P, Coupmax, Tmpeval, Evalmax, Courant, Coupmax2, Evalmax2),
%		enlever_coup(Courant, Jo),
%		(var(Coupmax) ->
%        	Coupmax = Coupmax2,
%        	Evalmax = Evalmax2,
%        	boucle(Liste_coups , P , J, Evalmax, Coupmax);
%        	boucle(Liste_coups , P , J, Evalmax2, Coupmax2)
%    	).


%%%% Recursive predicate for playing the game.
% The game is over, we use a cut to stop the proof search, and display the winner/board.
playHu(Player,NewPos):- nonvar(NewPos),gameover(Player,NewPos), !, write('Game is Over. Winner: '), writeln(Player), displayBoard.
% The game is not over, we play the next turn
playHu(Player,_):- changePlayer(Player,NextPlayer), % Change the player before next turn
    		write('New turn for:'), writeln(NextPlayer),
    		board(Board), % instanciate the board from the knowledge base
       	    displayBoard, % print it
            human(Board, Move), % ask the AI for a move, that is, an index for the Player
    	    playMove(Board,Move,NewBoard,NextPlayer), % Play the move and get the result in a new Board
		    applyIt(Board, NewBoard), % Remove the old board from the KB and store the new one
            playIA(NextPlayer,Move). % next turn!

% The game is over, we use a cut to stop the proof search, and display the winner/board.
playIA(Player,NewPos):- nonvar(NewPos),gameover(Player,NewPos), !, write('Game is Over. Winner: '), writeln(Player), displayBoard.
playIA(Player,_):- changePlayer(Player,NextPlayer), % Change the player before next turn
    		write('New turn for:'), writeln(NextPlayer),
    		board(Board), % instanciate the board from the knowledge base
       	    displayBoard, % print it
            ia(Board, Move,NextPlayer), % ask the AI for a move, that is, an index for the Player
    	    playMove(Board,Move,NewBoard,NextPlayer), % Play the move and get the result in a new Board
		    applyIt(Board, NewBoard), % Remove the old board from the KB and store the new one
            playHu(NextPlayer,Move). % next turn!


%%%% Recursive predicate for playing the game.
% The game is over, we use a cut to stop the proof search, and display the winner/board.
play(Player,NewPos):- nonvar(NewPos),gameover(Player,NewPos), !, write('Game is Over. Winner: '), writeln(Player), displayBoard.
% The game is not over, we play the next turn
play(Player,_):- changePlayer(Player,NextPlayer), % Change the player before next turn
    		write('New turn for:'), writeln(NextPlayer),
    		board(Board), % instanciate the board from the knowledge base
       	    displayBoard, % print it
            ia(Board, Move,NextPlayer), % ask the AI for a move, that is, an index for the Player
    	    playMove(Board,Move,NewBoard,NextPlayer), % Play the move and get the result in a new Board
		    applyIt(Board, NewBoard), % Remove the old board from the KB and store the new one
            play(NextPlayer,Move). % next turn!

%%%% Play a Move, the new Board will be the same, but one value will be instanciated with the Move
playMove(Board,Move,NewBoard,Player) :- Board=NewBoard,  nth0(Move,NewBoard,Player).
%%%% Remove old board/save new on in the knowledge base
applyIt(Board,NewBoard) :- retract(board(Board)), assert(board(NewBoard)).

%%%% Predicate to get the next player
changePlayer('B','N').
changePlayer('N','B').

%%%% Print the value of the board at index N:
% if its a variable, print ? and b or n otherwise.
printVal(N) :- board(B), nth0(N,B,Val), var(Val), write(' . '), !.
printVal(N) :- board(B), nth0(N,B,Val), write(Val).

%%%% Print all the values of a list
len([],0).
len([_|Y],R) :- len(Y,A),R is A+1.
printList(L):-len(L,Len),I is Len-1,printListVal(L,I).
printValOfList(L,0) :- nth0(0,L,Val), writeln(Val).
printValOfList(L,N) :- nth0(N,L,Val), writeln(Val), Next is N-1, printValOfList(L,Next).

%%%% Display the board
displayBoard:-
    writeln('*-----------------------*'),
    printVal(0), printVal(1), printVal(2), printVal(3), printVal(4), printVal(5), printVal(6), printVal(7), printVal(8), printVal(9), printVal(10), printVal(11), printVal(12), printVal(13), printVal(14), writeln(''),
    printVal(15), printVal(16), printVal(17), printVal(18), printVal(19), printVal(20), printVal(21), printVal(22), printVal(23), printVal(24), printVal(25), printVal(26), printVal(27), printVal(28), printVal(29), writeln(''),
    printVal(30), printVal(31), printVal(32), printVal(33), printVal(34), printVal(35), printVal(36), printVal(37), printVal(38), printVal(39), printVal(40), printVal(41), printVal(42), printVal(43), printVal(44), writeln(''),
    printVal(45), printVal(46), printVal(47), printVal(48), printVal(49), printVal(50), printVal(51), printVal(52), printVal(53), printVal(54), printVal(55), printVal(56), printVal(57), printVal(58), printVal(59), writeln(''),
    printVal(60), printVal(61), printVal(62), printVal(63), printVal(64), printVal(65), printVal(66), printVal(67), printVal(68), printVal(69), printVal(70), printVal(71), printVal(72), printVal(73), printVal(74), writeln(''),
    printVal(75), printVal(76), printVal(77), printVal(78), printVal(79), printVal(80), printVal(81), printVal(82), printVal(83), printVal(84), printVal(85), printVal(86), printVal(87), printVal(88), printVal(89), writeln(''),
    printVal(90), printVal(91), printVal(92), printVal(93), printVal(94), printVal(95), printVal(96), printVal(97), printVal(98), printVal(99), printVal(100), printVal(101), printVal(102), printVal(103), printVal(104), writeln(''),
    printVal(105), printVal(106), printVal(107), printVal(108), printVal(109), printVal(110), printVal(111), printVal(112), printVal(113), printVal(114), printVal(115), printVal(116), printVal(117), printVal(118), printVal(119), writeln(''),
    printVal(120), printVal(121), printVal(122), printVal(123), printVal(124), printVal(125), printVal(126), printVal(127), printVal(128), printVal(129), printVal(130), printVal(131), printVal(132), printVal(133), printVal(134), writeln(''),
    printVal(135), printVal(136), printVal(137), printVal(138), printVal(139), printVal(140), printVal(141), printVal(142), printVal(143), printVal(144), printVal(145), printVal(146), printVal(147), printVal(148), printVal(149), writeln(''),
    printVal(150), printVal(151), printVal(152), printVal(153), printVal(154), printVal(155), printVal(156), printVal(157), printVal(158), printVal(159), printVal(160), printVal(161), printVal(162), printVal(163), printVal(164), writeln(''),
    printVal(165), printVal(166), printVal(167), printVal(168), printVal(169), printVal(170), printVal(171), printVal(172), printVal(173), printVal(174), printVal(175), printVal(176), printVal(177), printVal(178), printVal(179), writeln(''),
    printVal(180), printVal(181), printVal(182), printVal(183), printVal(184), printVal(185), printVal(186), printVal(187), printVal(188), printVal(189), printVal(190), printVal(191), printVal(192), printVal(193), printVal(194), writeln(''),
    printVal(195), printVal(196), printVal(197), printVal(198), printVal(199), printVal(200), printVal(201), printVal(202), printVal(203), printVal(204), printVal(205), printVal(206), printVal(207), printVal(208), printVal(209), writeln(''),
	printVal(210), printVal(211), printVal(212), printVal(213), printVal(214), printVal(215), printVal(216), printVal(217), printVal(218), printVal(219), printVal(220), printVal(221), printVal(222), printVal(223), printVal(224), writeln(''),
    writeln('*-----------------------*').

init :- length(Board,225), assert(board(Board)), choice().

%%% User inputs
promptInput(R,C) :-
    write('Next move (\'row,column\') :'),
    read(M),
    split_string(M,',',',',[X,Y|_]),
    number_codes(R,X),
    number_codes(C,Y).
promptMode(M) :- write('choose game mode: (\'H\' for Human vs AI, anything else for AI vs AI)'), read(M).
promptMode2(M) :-write('choose game mode: (\'1\' for AI hard vs AI medium, anything else for AI medium vs AI easy)'), read(M).
