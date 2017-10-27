



%%%------------------------------------%%%
%%Min max algo part

%%%------------------------------------%%%
%%Min max algo part
%recursive call
%points are all the possible moves
%best is the best score 
%Resultlist is all the positions with the best score in current recursive call
%ResultlistFinal is all the positions with the best score
%alpha beta are used to cut branches


minmaxRecursive(_,_,_,0,_,_,ResultListFinal,ResultListFinal,_,_):-!.
minmaxRecursive(Board,Player,Deep,Index,Points,Best,ResultList,ResultListFinal,Alpha,Beta):-
    element(Index,Move,Points),
    playMove(Board,Move,NewBoard,Player),
    NewDeep is Deep-1,
    changePlayer(Player,NextPlayer),
    updateBeta(Best,Beta,NewBeta),
    minScore(NewBoard,NextPlayer,NewDeep,Move,Valeur,Alpha,NewBeta),
    NextIndex is Index-1,
    updateBest(Valeur,Best,NewBest,ResultList,NewResultList,Move),
    minmaxRecursive(Board,Player,Deep,NextIndex,Points,NewBest,NewResultList,ResultListFinal,Alpha,Beta).

%update the best score
updateBest(Valeur,Best,Valeur,_,[Move],Move):-Valeur>Best,!.   
updateBest(Valeur,Best,Best,ResultList,[Move|ResultList],Move):-Valeur==Best,!.
updateBest(Valeur,Best,Best,ResultList,ResultList,_):-Valeur<Best.

%%minmax call
minmax(Board,Player,Deep,Result):-
    searchPossibleMoves(Board,Deep,PossibleMoves),
    manipulatePossibleMoves(Board,Player,Deep,Result,PossibleMoves),!.

manipulatePossibleMoves(_,_,_,Result,PossibleMoves):-
    PossibleMoves==[],
    Result=113,!.
manipulatePossibleMoves(_,_,_,Result,PossibleMoves):-
    len(PossibleMoves,L),
    L==24,
    nth0(23,PossibleMoves,Result),!.
manipulatePossibleMoves(Board,Player,Deep,Result,PossibleMoves):-
    len(PossibleMoves,L),
    minmaxRecursive(Board,Player,Deep,L,PossibleMoves,-99999999,[],ResultList,9999999,-9999999),
    len(ResultList,L2),
    RandomIndex is random(L2),
    nth0(RandomIndex,ResultList,Result),!.
manipulatePossibleMoves(Board,Player,Deep,Result,PossibleMoves):-
    len([PossibleMoves],L),
   	minmaxRecursive(Board,Player,Deep,L,[PossibleMoves],-99999999,[],ResultList,9999999,-9999999),
    len(ResultList,L2),
    RandomIndex is random(L2),
    nth0(RandomIndex,ResultList,Result).
    

minScoreRecursive(_,_,_,0,_,BestFinal,BestFinal,_,_):-!.
minScoreRecursive(Board,Player,Deep,Index,Points,Best,BestFinal,Alpha,Beta):-
    element(Index,Move,Points),
    playMove(Board,Move,NewBoard,Player),
    NewDeep is Deep-1,
    changePlayer(Player,NextPlayer),
    updateAlpha(Best,Alpha,NewAlpha),
    maxScore(NewBoard,NextPlayer,NewDeep,Move,Valeur,NewAlpha,Beta),
    NextIndex is Index-1,
    updateBestMin(Valeur,Best,NewBest),
    (   Valeur<Beta ->  
    	BestFinal = NewBest
    ;   minScoreRecursive(Board,Player,Deep,NextIndex,Points,NewBest,BestFinal,Alpha,Beta)
    ).
    
updateBestMin(Valeur,Best,NewBest):-Valeur<Best,NewBest is Valeur,!.
updateBestMin(_,Best,NewBest):-NewBest is Best.
updateAlpha(Best,Alpha,Best):-Best<Alpha,!.
updateAlpha(_,Alpha,Alpha).

minScore(Board,Player,Deep,_,Best,_,_):-Deep<1,changePlayer(Player,NextPlayer),evaluateTotalScore(Board,NextPlayer,Best),!.
minScore(Board,Player,_,LastMove,Best,_,_):-
    changePlayer(Player,LastPlayer),
    winner(Board,LastPlayer,LastMove),
    evaluateTotalScore(Board,Player,Best),!.
minScore(Board,Player,Deep,_,BestFinal,Alpha,Beta):-
    searchPossibleMoves(Board,Deep,PossibleMoves),
    len(PossibleMoves,L),
    minScoreRecursive(Board,Player,Deep,L,PossibleMoves,9999999,BestFinal,Alpha,Beta),!.

maxScoreRecursive(_,_,_,0,_,BestFinal,BestFinal,_,_):-!.
maxScoreRecursive(Board,Player,Deep,Index,Points,Best,BestFinal,Alpha,Beta):-
    element(Index,Move,Points),
    playMove(Board,Move,NewBoard,Player),
    NewDeep is Deep-1,
    changePlayer(Player,NextPlayer),
    updateBeta(Best,Beta,NewBeta),
    minScore(NewBoard,NextPlayer,NewDeep,Move,Valeur,Alpha,NewBeta),
    NextIndex is Index-1,
    updateBestMax(Valeur,Best,NewBest),
    (   Valeur>Alpha ->  
    	BestFinal=NewBest
    ;   maxScoreRecursive(Board,Player,Deep,NextIndex,Points,NewBest,BestFinal,Alpha,Beta)
    ).
    
updateBestMax(Valeur,Best,NewBest):-Valeur>Best,NewBest is Valeur,!.
updateBestMax(_,Best,NewBest):-NewBest is Best.
updateBeta(Best,Beta,Best):-Best>Beta,!.
updateBeta(_,Beta,Beta).

maxScore(Board,Player,Deep,_,Best,_,_):-Deep<1,evaluateTotalScore(Board,Player,Best),!.
maxScore(Board,Player,_,LastMove,Best,_,_):-
    changePlayer(Player,LastPlayer),
    winner(Board,LastPlayer,LastMove),
    evaluateTotalScore(Board,Player,Best),!.
maxScore(Board,Player,Deep,_,BestFinal,Alpha,Beta):-
    searchPossibleMoves(Board,Deep,PossibleMoves),
    len(PossibleMoves,L),
    maxScoreRecursive(Board,Player,Deep,L,PossibleMoves,-999999,BestFinal,Alpha,Beta).






