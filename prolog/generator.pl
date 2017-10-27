
accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos-1,isPosBelong(Board,Player,Pos),accRightFree(Board,Player,NewPos,MaxAcc,MaxAcc,1),!.
accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos-1,isPosEmpty(Board,Pos),accRightFree(Board,Player,NewPos,MaxAcc,MaxAcc,2),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+1,isPosEmpty(Board,Pos),accLeftFree(Board,Player,NewPos,MaxAcc),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+15,isPosBelong(Board,Player,Pos),accUpFree(Board,Player,NewPos,MaxAcc,MaxAcc,1),!.
accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+15,isPosEmpty(Board,Pos),accUpFree(Board,Player,NewPos,MaxAcc,MaxAcc,2),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos-15,isPosEmpty(Board,Pos),accDownFree(Board,Player,NewPos,MaxAcc),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+14,isPosBelong(Board,Player,Pos),accUpperRightFree(Board,Player,NewPos,MaxAcc,MaxAcc,1),!.
accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+14,isPosEmpty(Board,Pos),accUpperRightFree(Board,Player,NewPos,MaxAcc,MaxAcc,2),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos-14,isPosEmpty(Board,Pos),accLowerLeftFree(Board,Player,NewPos,MaxAcc),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+16,isPosBelong(Board,Player,Pos),accUpperLeftFree(Board,Player,NewPos,MaxAcc,MaxAcc,1),!.
accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos+16,isPosEmpty(Board,Pos),accUpperLeftFree(Board,Player,NewPos,MaxAcc,MaxAcc,2),!.

accmulatorFree(Board,Player,NewPos,MaxAcc):-Pos is NewPos-16,isPosEmpty(Board,Pos),accLowerRightFree(Board,Player,NewPos,MaxAcc).

countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,0):-
    (   Pos is NewPos-1,
  		isPosBelong(Board,Player,Pos),
        accRightFree(Board,Player,NewPos,Acc,Acc,1)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,1),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,1)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,1):-
    (   Pos is NewPos-1,
        isPosEmpty(Board,Pos),
        accRightFree(Board,Player,NewPos,Acc,Acc,2)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,2),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,2)
    ),!. 

countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,2):-
    (   Pos is NewPos+1,
        isPosEmpty(Board,Pos),
        accLeftFree(Board,Player,NewPos,Acc)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,3),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,3)
    ),!.    	

countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,3):-
    (   Pos is NewPos+15,
        isPosBelong(Board,Player,Pos),
        accUpFree(Board,Player,NewPos,Acc,Acc,1)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,4),
    	NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,4)
    ),!. 
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,4):-
    (   Pos is NewPos+15,
        isPosEmpty(Board,Pos),
        accUpFree(Board,Player,NewPos,Acc,Acc,2)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,5),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,5)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,5):-
    (   Pos is NewPos-15,
        isPosEmpty(Board,Pos),
        accDownFree(Board,Player,NewPos,Acc)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,6),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,6)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,6):-
    (   Pos is NewPos+14,
        isPosBelong(Board,Player,Pos),
        accUpperRightFree(Board,Player,NewPos,Acc,Acc,1)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,7),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,7)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,7):-
    (   Pos is NewPos+14,
        isPosEmpty(Board,Pos),
        accUpperRightFree(Board,Player,NewPos,Acc,Acc,2)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,8),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,8)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,8):-
    (   Pos is NewPos-14,
        isPosEmpty(Board,Pos),
        accLowerLeftFree(Board,Player,NewPos,Acc)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,9),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,9)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,9):-
    (   Pos is NewPos+16,
        isPosBelong(Board,Player,Pos),
        accUpperLeftFree(Board,Player,NewPos,Acc,Acc,1)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,10),
        NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,10)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,10):-
    (   Pos is NewPos+16,
        isPosEmpty(Board,Pos),
        accUpperLeftFree(Board,Player,NewPos,Acc,Acc,2)->
    	countDirectionFree(Board,Player,NewPos,Acc,NumDirection,11),
    	NewNumDirection is NumDirection+1
    ;   countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,11)
    ),!.
countDirectionFree(Board,Player,NewPos,Acc,NewNumDirection,11):-
    (   Pos is NewPos-16,
        isPosEmpty(Board,Pos),
        accLowerRightFree(Board,Player,NewPos,Acc)->
    	NewNumDirection=1
    ;   NewNumDirection=0
    ),!.



accRightFree(Board,_,NewPos,1,_,_):-
    Pos is NewPos+1,
    X is mod(Pos,15),
    X\==0,
    isPosEmpty(Board,Pos),!.
accRightFree(Board,Player,NewPos,NewAcc,MaxAcc,Type):-
	Pos is NewPos+1,
	X is mod(Pos,15),
    X\==0,
    Acc is NewAcc-1,
	isPosBelong(Board,Player,Pos),
	accRightFree(Board,Player,Pos,Acc,MaxAcc,Type),!.
accRightFree(Board,Player,NewPos,_,MaxAcc,1):-
    Pos is NewPos+1,
    X is mod(Pos,15),
    X\==0,
    isPosEmpty(Board,Pos),
    accLeftFree(Board,Player,NewPos,MaxAcc).

accLeftFree(Board,_,NewPos,1):-
    Pos is NewPos-1,
    X is mod(Pos,15),
    X\==14,
    isPosEmpty(Board,Pos),!.
accLeftFree(Board,Player,NewPos,NewAcc):-
    Pos is NewPos-1,
    X is mod(Pos,15),
    X\==14,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLeftFree(Board,Player,Pos,Acc).

accUpFree(Board,_,NewPos,1,_,_):-
    Pos is NewPos-15,
    Pos>=0,
    isPosEmpty(Board,Pos),!.
accUpFree(Board,Player,NewPos,NewAcc,MaxAcc,Type):-
    Pos is NewPos-15,
    Pos>=0,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUpFree(Board,Player,Pos,Acc,MaxAcc,Type),!.
accUpFree(Board,Player,NewPos,_,MaxAcc,1):-
    Pos is NewPos-15,
    Pos>=0,
    isPosEmpty(Board,Pos),
    accDownFree(Board,Player,NewPos,MaxAcc).

accDownFree(Board,_,NewPos,1):-
    Pos is NewPos+15,
    Pos<225,
    isPosEmpty(Board,Pos),!.
accDownFree(Board,Player,NewPos,NewAcc):-
    Pos is NewPos+15,
    Pos<225,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accDownFree(Board,Player,Pos,Acc).

accUpperRightFree(Board,_,NewPos,1,_,_):-
    Pos is NewPos-14,
    Pos>=0,
    X is mod(NewPos,15),
    X\==14,
    isPosEmpty(Board,Pos),!.
accUpperRightFree(Board,Player,NewPos,NewAcc,MaxAcc,Type):-
    Pos is NewPos-14,
    Pos>=0,
    X is mod(NewPos,15),
    X\==14,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUpperRightFree(Board,Player,Pos,Acc,MaxAcc,Type),!.
accUpperRightFree(Board,Player,NewPos,_,MaxAcc,1):-
    Pos is NewPos-14,
    Pos>=0,
    X is mod(NewPos,15),
    X\==14,
    isPosEmpty(Board,Pos),
    accLowerLeftFree(Board,Player,NewPos,MaxAcc).

accLowerLeftFree(Board,_,NewPos,1):-
    Pos is NewPos+14,
    Pos<225,
    X is mod(NewPos,15),
    X\==0,
    isPosEmpty(Board,Pos),!.
accLowerLeftFree(Board,Player,NewPos,NewAcc):-
    Pos is NewPos+14,
    Pos<225,
    X is mod(NewPos,15),
    X\==0,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLowerLeftFree(Board,Player,Pos,Acc).

accUpperLeftFree(Board,_,NewPos,1,_,_):-
    Pos is NewPos-16,
    Pos>=0,
    X is mod(NewPos,15),
    X\==0,
    isPosEmpty(Board,Pos),!.
accUpperLeftFree(Board,Player,NewPos,NewAcc,MaxAcc,Type):-
    Pos is NewPos-16,
    Pos>=0,
    X is mod(NewPos,15),
    X\==0,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accUpperLeftFree(Board,Player,Pos,Acc,MaxAcc,Type),!.
accUpperLeftFree(Board,Player,NewPos,_,MaxAcc,1):-
    Pos is NewPos-16,
    Pos>=0,
    X is mod(NewPos,15),
    X\==0,
    isPosEmpty(Board,Pos),
    accLowerRightFree(Board,Player,NewPos,MaxAcc).

accLowerRightFree(Board,_,NewPos,1):-
    Pos is NewPos+16,
    Pos<225,
    X is mod(NewPos,15),
    X\==14,
    isPosEmpty(Board,Pos),!.
accLowerRightFree(Board,Player,NewPos,NewAcc):-
	Pos is NewPos+16,
    Pos<225,
    X is mod(NewPos,15),
    X\==14,
    Acc is NewAcc-1,
    isPosBelong(Board,Player,Pos),
    accLowerRightFree(Board,Player,Pos,Acc).


%%%Chercher les positions qui a au moins un voisin et les afficher.
%HasNeighbors: les positions qui a aumoins un voisin à 1 case à coté de lui.
%NextNeighbors: les positions qui a aumoins un voisin à 2 cases à coté de lui.
%Pour l'appeler: gererator(Board,224,HasNeighbors,NextNeighbors).
generator(_,_,-1,[],[],[],[],[],[],[]):-!.
generator(Board,Deep,P,[P|HasNeighbors],NextNeighbors,NewHasFive,NewHasFour,NewHasTwoThree,NewHasThree,NewHasTwo):-
    hasNeighbors(Board,P),
    NextP is P-1,
    generator(Board,Deep,NextP,HasNeighbors,NextNeighbors,HasFive,HasFour,HasTwoThree,HasThree,HasTwo),
    updateHasFive(Board,P,HasFive,NewHasFive),
    updateHasFour(Board,P,HasFour,NewHasFour),
    updateTwoThree(Board,P,HasTwoThree,NewHasTwoThree),
    updateThree(Board,P,HasThree,NewHasThree),
    updateTwo(Board,P,HasTwo,NewHasTwo),!.
generator(Board,Deep,P,HasNeighbors,[P|NextNeighbors],HasFive,HasFour,HasTwoThree,HasThree,HasTwo):-
    Deep>1,
    nextNeighbors(Board,P),
    NextP is P-1,
    generator(Board,Deep,NextP,HasNeighbors,NextNeighbors,HasFive,HasFour,HasTwoThree,HasThree,HasTwo),!.

generator(Board,Deep,P,HasNeighbors,NextNeighbors,HasFive,HasFour,HasTwoThree,HasThree,HasTwo):-
    NextP is P-1,
    generator(Board,Deep,NextP,HasNeighbors,NextNeighbors,HasFive,HasFour,HasTwoThree,HasThree,HasTwo).

updateHasFive(Board,P,HasFive,[P|HasFive]):-hasFive(Board,P),!.
updateHasFive(_,_,HasFive,HasFive).


updateHasFour(Board,P,HasFour,[P|HasFour]):-hasFourFree(Board,P),!.
updateHasFour(_,_,HasFour,HasFour).


updateTwoThree(Board,P,HasTwoThree,[P|HasTwoThree]):-hasTwoThree(Board,P),!.
updateTwoThree(_,_,HasTwoThree,HasTwoThree).

updateThree(Board,P,HasThree,[P|HasThree]):-hasThree(Board,P),!.
updateThree(_,_,HasThree,HasThree).

updateTwo(Board,P,HasTwo,[P|HasTwo]):-hasTwo(Board,P),!.
updateTwo(_,_,HasTwo,HasTwo).

hasFive(Board,P):-
    playMove(Board,P,NewBoard,'B'),
    accmulator(NewBoard,'B',P,5),!.
hasFive(Board,P):-
    playMove(Board,P,NewBoard,'N'),
    accmulator(NewBoard,'N',P,5).

hasFourFree(Board,P):-
	playMove(Board,P,NewBoard,'N'),
    accmulatorFree(NewBoard,'N',P,4),!.
hasFourFree(Board,P):-
	playMove(Board,P,NewBoard,'B'),
    accmulatorFree(NewBoard,'B',P,4).

hasTwoThree(Board,P):-
	playMove(Board,P,NewBoard,'N'),
    countDirectionFree(NewBoard,'N',P,3,NewNumDirection,0),
    NewNumDirection==2,!.
hasTwoThree(Board,P):-
	playMove(Board,P,NewBoard,'B'),
    countDirectionFree(NewBoard,'B',P,3,NewNumDirection,0),
    NewNumDirection==2,!.

hasThree(Board,P):-
	playMove(Board,P,NewBoard,'N'),
    accmulatorFree(NewBoard,'N',P,3),!.
hasThree(Board,P):-
	playMove(Board,P,NewBoard,'B'),
    accmulatorFree(NewBoard,'B',P,3).

hasTwo(Board,P):-
	playMove(Board,P,NewBoard,'N'),
    accmulatorFree(NewBoard,'N',P,2),!.
hasTwo(Board,P):-
	playMove(Board,P,NewBoard,'B'),
    accmulatorFree(NewBoard,'B',P,2).

    
    
    
searchPossibleMoves(Board,Deep,PossibleMoves):-
    generator(Board,Deep,224,HasNeighbors,NextNeighbors,HasFive,HasFour,HasTwoThree,HasThree,HasTwo),
    (   HasFive\==[]->
    	nth0(0,HasFive,FistElem),
    	PossibleMoves = [FistElem]
    ;   HasFour\==[]->
    	nth0(0,HasFour,FistElem2),
    	PossibleMoves = [FistElem2]
    ;   HasTwoThree\==[]->
    	nth0(0,HasTwoThree,FistElem3),
    	PossibleMoves = [FistElem3]
    ;	HasThree\==[]->
    	PossibleMoves = HasThree
    ;   append(NextNeighbors,HasNeighbors,Points),
        append(Points,HasTwo,ListPossibleMoves),
        list2ens(ListPossibleMoves,PossibleMoves)
    ),!.




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

