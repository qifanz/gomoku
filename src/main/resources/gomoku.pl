:- dynamic board/1.
init :- length(Board,225),nth0(15,Board,'X'),nth0(169,Board,'X'),nth0(197,Board,'X'),nth0(183,Board,'X'),assert(board(Board)),play('X').

%A partir de la position de portion courante, chercher les pions de même couleur aux positions adjacentes en suivant toujours la même direction, jusqu'à l'accumulateur se décrémente à 1.
winner(Board,P,NewPos):-accRight(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accLeft(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accUp(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accDown(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accUpperRight(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accLowerLeft(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accUpperLeft(Board,P,NewPos,5),write('winner'),!.
winner(Board,P,NewPos):-accLowerRight(Board,P,NewPos,5),write('winner').


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

isPosEmpty(Board,Pos):-nth0(Pos,Board,Elem),var(Elem).
isPosNotBelong(_,Pos):-board(Board),isPosEmpty(Board,Pos).
isPosNotBelong(Player,Pos):-board(Board),nth0(Pos,Board,Elem),nonvar(Elem),Elem\==Player.
isPosBelong(Player,Pos):-board(Board),nth0(Pos,Board,Elem),nonvar(Elem),Elem==Player.

%%%Chercher les positions qui a au moins un voisin.
%generator(_,224,HasNeighbors,NextNeighbors):-nonvar(HasNeighbors),len(HasNeighbors,L1),LHN is L1-1,printList(HasNeighbors,LHN),len(NextNeighbors,L2),LNB is L2-1,printList(NextNeighbors,LNB).
%generator(Board,P,HasNeighbors,NextNeighbors):-hasNeighbors(Board,P),NextP is P+1,generator(Board,NextP,[P|HasNeighbors],NextNeighbors),!.
%generator(Board,P,HasNeighbors,NextNeighbors):-nextNeighbors(Board,P),NextP is P+1,generator(Board,NextP,HasNeighbors,[P|NextNeighbors]),!.
%igenerator(Board,P,HasNeighbors,NextNeighbors):-NextP is P+1,generator(Board,NextP,HasNeighbors,NextNeighbors).

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


%valeur d'evaluation d'une chaîne de pions en fonction de nombre de pions successifs et nombre de pions qui bloquent.
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



countBlock(PosInit,PosFinal,2,15):-board(Board),Pos1 is PosInit-15,Pos1<0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,2,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2>224,\+isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,2,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(PosInit,PosFinal,1,15):-board(Board),Pos1 is PosInit-15,Pos1<0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,1,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2>224,isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,1,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,\+isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,1,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(PosInit,PosFinal,0,15):-board(Board),Pos1 is PosInit-15,Pos1>=0,Pos2 is PosFinal+15,Pos2<225,isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.



countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>224,\+isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2<0,\+isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>224,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1<0,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,\+isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>224,!.
countBlock(PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2<0,!.
countBlock(PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>224,!.
countBlock(PosInit,PosFinal,2,Inc):-X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1<0,!.
countBlock(PosInit,PosFinal,2,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2<0,isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>224,isPosEmpty(Board,Pos1),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos1),\+isPosEmpty(Board,Pos2),!.

countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X==0,Y is mod(PosFinal,15),Y\==14,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1<0,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>224,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos2),!.
countBlock(PosInit,PosFinal,1,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,\+isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.

countBlock(PosInit,PosFinal,0,Inc):-board(Board),X is mod(PosInit,15),X\==0,Y is mod(PosFinal,15),Y\==14,Pos1 is PosInit-Inc,Pos1>=0,Pos1<225,Pos2 is PosFinal+Inc,Pos2>=0,Pos2<225,isPosEmpty(Board,Pos1),isPosEmpty(Board,Pos2),!.

maxSeries(_,Pos,1,1):-X is mod(Pos,15),X==14,!.
maxSeries(_,Pos,1,15):-Pos>209,!.
maxSeries(_,Pos,1,16):-Pos>209,!.
maxSeries(_,Pos,1,16):-X is mod(Pos,15),X==14,!.
maxSeries(_,Pos,1,-14):-Pos<15,!.
maxSeries(_,Pos,1,-14):-X is mod(Pos,15),X==14,!.
maxSeries(Player,Pos,1,Inc):-NextPos is Pos + Inc,isPosNotBelong(Player,NextPos),!.
maxSeries(Player,Pos,Acc,Inc):-NextPos is Pos + Inc,maxSeries(Player,NextPos,NextAcc,Inc),Acc is NextAcc+1.

evaluateSeries(Player,Pos,PosFinal,Inc,Valeur):-maxSeries(Player,Pos,Acc,Inc),PosFinal is Pos+(Acc-1)*Inc,countBlock(Pos,PosFinal,NumBlock,Inc),evaluateState(Acc,NumBlock,Valeur).

%%% elemNotEmpty(Player,PosInit,PosFinal,Inc) Chercher le premier element de même couleur de Player à partir de PosInit, en cas d'échec, on incrémente Inc à la position courante.
firstElemOfPlayer(Player,Pos,PosOfPlayer,_):-board(Board),nth0(Pos,Board,Elem),nonvar(Elem),Elem==Player,PosOfPlayer is Pos,!.
firstElemOfPlayer(_,Pos,-1,_):-Pos>224,!. %Il n'y a plus de portion
firstElemOfPlayer(_,Pos,-1,16):-X is mod(Pos,15),X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,Pos,-1,-14):-X is mod(Pos,15),X==14,!. %Il n'y a plus de portion
firstElemOfPlayer(_,Pos,-1,-14):-Pos<0,!. %Il n'y a plus de portion
firstElemOfPlayer(Player,PosInit,PosOfPlayer,Inc):-NextPos is PosInit+Inc,firstElemOfPlayer(Player,NextPos,PosOfPlayer,Inc).

evaluateLine(Player,Pos,Inc,0):-firstElemOfPlayer(Player,Pos,PosOfPlayer,Inc),PosOfPlayer<0,!.
evaluateLine(Player,Pos,Inc,ValeurLine):-firstElemOfPlayer(Player,Pos,PosOfPlayer,Inc),PosOfPlayer>=0,evaluateSeries(Player,PosOfPlayer,PosFinal,Inc,Valeur),NextPos is PosFinal+Inc,evaluateLine(Player,NextPos,Inc,NextValeurLine),ValeurLine is NextValeurLine + Valeur.


% Pos [0,224]
evaluateLineHorizontalTotal(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,1,ValeurTotal).%
    
evaluateLineVerticalTotal(_,15,0):-!.
%% Pos [0,14]
evaluateLineVerticalTotal(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,15,ValeurLine),NextPos is Pos+1,evaluateLineVerticalTotal(Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.


evaluateLineLowerRightTotal1(_,15,0):-!.
%% Pos [0,14]
evaluateLineLowerRightTotal1(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,16,ValeurLine),NextPos is Pos+1,evaluateLineLowerRightTotal1(Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineLowerRightTotal2(_,225,0):-!.
%% Pos {15,30,45,...,210}
evaluateLineLowerRightTotal2(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,16,ValeurLine),NextPos is Pos+15,evaluateLineLowerRightTotal2(Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal1(_,225,0):-!.
%% Pos {0,15,...210}
evaluateLineUpperRightTotal1(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,-14,ValeurLine),NextPos is Pos+15,evaluateLineUpperRightTotal1(Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateLineUpperRightTotal2(_,225,0):-!.
%% Pos [211,224]
evaluateLineUpperRightTotal2(Player,Pos,ValeurTotal):-evaluateLine(Player,Pos,-14,ValeurLine),NextPos is Pos+1,evaluateLineUpperRightTotal2(Player,NextPos,NextValeurTotal),ValeurTotal is NextValeurTotal+ValeurLine.

evaluateTotal(Player,Valeur):-evaluateLineHorizontalTotal(Player,0,Valeur1),evaluateLineVerticalTotal(Player,0,Valeur2),evaluateLineLowerRightTotal1(Player,0,Valeur3),evaluateLineLowerRightTotal2(Player,15,Valeur4),evaluateLineUpperRightTotal1(Player,0,Valeur5),evaluateLineUpperRightTotal2(Player,211,Valeur6),Valeur is Valeur1+Valeur2+Valeur3+Valeur4+Valeur5+Valeur6.
%%evaluateLineHorizontalTotal('X',0,Valeur)
%%evaluateLineVerticalTotal('X',0,Valeur)
%%evaluateLineLowerRightTotal1('X',0,Valeur)
%%evaluateLineLowerRightTotal2('X',15,Valeur)
%%evaluateLineUpperRightTotal1('X',0,Valeur)
%%evaluateLineUpperRightTotal2('X',211,Valeur)
play(_):-evaluateTotal('X',Valeur),writeln(Valeur).
%generator(Board,224,HasNeighbors,NextNeighbors),len(HasNeighbors,L1),LHN is L1-1,printList(HasNeighbors,LHN),len(NextNeighbors,L2),LNB is L2-1,printList(NextNeighbors,LNB).
    
len([],0).
len([_|Y],R) :- len(Y,A),R is A+1.
printList(L,0) :- nth0(0,L,Val), writeln(Val).
printList(L,N) :- nth0(N,L,Val), writeln(Val), Next is N-1, printList(L,Next).



printVal(N) :- board(B), nth0(N,B,Val), var(Val), write(' . '), !.
printVal(N) :- board(B), nth0(N,B,Val), write(Val).
displayBoard:-
    writeln('*-----------------------*'),
    printVal(0), printVal(1), printVal(2), printVal(3), printVal(4), printVal(5), writeln(''),
    writeln('*-----------------------*').