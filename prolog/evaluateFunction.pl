
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
evaluateState(SameColorContinous,_,100000):-SameColorContinous>4,!.


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
sameColorContinous(_,_,Pos,1,1):-
    X is mod(Pos,15),
    X==14,!.
sameColorContinous(_,_,Pos,1,15):-
    Pos>209,!.
sameColorContinous(_,_,Pos,1,16):-
    Pos>209,!.
sameColorContinous(_,_,Pos,1,16):-
    X is mod(Pos,15),
    X==14,!.
sameColorContinous(_,_,Pos,1,-14):-
    Pos<15,!.
sameColorContinous(_,_,Pos,1,-14):-
    X is mod(Pos,15),
    X==14,!.
sameColorContinous(Board,Player,Pos,1,Inc):-
    NextPos is Pos + Inc,
    isPosNotBelong(Board,Player,NextPos),!.
sameColorContinous(Board,Player,Pos,Acc,Inc):-
    NextPos is Pos + Inc,
    sameColorContinous(Board,Player,NextPos,NextAcc,Inc),
    Acc is NextAcc+1.

%evaluate the value of a serie of piece
evaluateSeries(Board,Player,Pos,PosFinal,Inc,Valeur):-
    sameColorContinous(Board,Player,Pos,Acc,Inc),
    PosFinal is Pos+(Acc-1)*Inc,
    countBlock(Board,Pos,PosFinal,NumBlock,Inc),
    evaluateState(Acc,NumBlock,Valeur).


%%%find the first position of the piece of the player
%firstElemOfPlayer(Player,PosInit,PosOfPlayer,Inc)
%PosOfPlayer is the value find, if no result found, return -1
%Inc is the value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,_):-
    nth0(Pos,Board,Elem),
    nonvar(Elem),Elem==Player,
    PosOfPlayer is Pos,!.
firstElemOfPlayer(_,_,Pos,-1,_):-
    Pos>224,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,16):-
    X is mod(Pos,15),
    X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,-14):-
    X is mod(Pos,15),
    X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,_,Pos,-1,-14):-
    Pos<0,!. %Il n'y a plus de portion
firstElemOfPlayer(Board,Player,PosInit,PosOfPlayer,Inc):-
    NextPos is PosInit+Inc,
    firstElemOfPlayer(Board,Player,NextPos,PosOfPlayer,Inc).

%evaluate the score for a whole line(vertical, horizontal or diagonal)
%Inc is the value of every increment. (ex. 1 for horizontal, 15 for vertical, 16 and 14 for diagonal)
evaluateLine(Board,Player,Pos,Inc,0):-
    firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,Inc),
    PosOfPlayer<0,!.
evaluateLine(Board,Player,Pos,Inc,ValeurLine):-
    firstElemOfPlayer(Board,Player,Pos,PosOfPlayer,Inc),
    PosOfPlayer>=0,
    evaluateSeries(Board,Player,PosOfPlayer,PosFinal,Inc,Valeur),
    NextPos is PosFinal+Inc,
    evaluateLine(Board,Player,NextPos,Inc,NextValeurLine),
    ValeurLine is NextValeurLine + Valeur.

% Pos [0,224]
evaluateLineHorizontalTotal(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,1,ValeurTotal).%
    
evaluateLineVerticalTotal(_,_,15,0):-!.
%% Pos [0,14]
evaluateLineVerticalTotal(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,15,ValeurLine),
    NextPos is Pos+1,
    evaluateLineVerticalTotal(Board,Player,NextPos,NextValeurTotal),
    ValeurTotal is NextValeurTotal+ValeurLine.


evaluateLineLowerRightTotal1(_,_,15,0):-!.
%% Pos [0,14]
evaluateLineLowerRightTotal1(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,16,ValeurLine),
    NextPos is Pos+1,
    evaluateLineLowerRightTotal1(Board,Player,NextPos,NextValeurTotal),
    ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineLowerRightTotal2(_,_,225,0):-!.
%% Pos {15,30,45,...,210}
evaluateLineLowerRightTotal2(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,16,ValeurLine),
    NextPos is Pos+15,
    evaluateLineLowerRightTotal2(Board,Player,NextPos,NextValeurTotal),
    ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal1(_,_,225,0):-!.
%% Pos {0,15,...210}
evaluateLineUpperRightTotal1(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,-14,ValeurLine),
    NextPos is Pos+15,
    evaluateLineUpperRightTotal1(Board,Player,NextPos,NextValeurTotal),
    ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal2(_,_,225,0):-!.
%% Pos [211,224]
evaluateLineUpperRightTotal2(Board,Player,Pos,ValeurTotal):-
    evaluateLine(Board,Player,Pos,-14,ValeurLine),
    NextPos is Pos+1,
    evaluateLineUpperRightTotal2(Board,Player,NextPos,NextValeurTotal),
    ValeurTotal is NextValeurTotal+ValeurLine.

evaluateTotalScore(Board,Player1,Valeur):-
    evaluatePlayer(Board,Player1,Valeur1),
    changePlayer(Player1,Player2),
    evaluatePlayer(Board,Player2,Valeur2),
    Valeur is Valeur1 -Valeur2.
evaluatePlayer(Board,Player,Valeur):-
    evaluateLineHorizontalTotal(Board,Player,0,Valeur1),
    evaluateLineVerticalTotal(Board,Player,0,Valeur2),
    evaluateLineLowerRightTotal1(Board,Player,0,Valeur3),
    evaluateLineLowerRightTotal2(Board,Player,15,Valeur4),
    evaluateLineUpperRightTotal1(Board,Player,0,Valeur5),
    evaluateLineUpperRightTotal2(Board,Player,211,Valeur6),
    Valeur is Valeur1+Valeur2+Valeur3+Valeur4+Valeur5+Valeur6.


