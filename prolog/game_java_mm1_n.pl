:- dynamic board/1.
init(X) :- length(Board,225),play('N',X).
play(_,Result):-board(Board),
    minmax(Board,Player,1,Result).
playMove(Board,Move,NewBoard,Player) :- length(NewBoard,225),copyBoard(Board,NewBoard,224),nth0(Move,NewBoard,Player).

%%%% Remove old board/save new on in the knowledge base
applyIt(Board,NewBoard) :- retract(board(Board)), assert(board(NewBoard)).

%%%% Predicate to get the next player
changePlayer('B','N').
changePlayer('N','B').
