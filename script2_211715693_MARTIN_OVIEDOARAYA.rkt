#lang racket
(require "TDApiece_21171569_OviedoAraya.rkt")
(require "TDAplayer_21171569_OviedoAraya.rkt")
(require "TDAboard_21171569_OviedoAraya.rkt")
(require "TDAgame_21171569_OviedoAraya.rkt")


(define p1 (player 1 "Tiffany" "red" 3 1 0 15))     
(define p2 (player 2 "Cristopher" "yellow" 1 3 0 15)) 


(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))


(define empty-board (board))


(define g0 (game p1 p2 empty-board 1))


(define g1 (game-player-set-move g0 p1 2))   
(define g2 (game-player-set-move g1 p2 6))    
(define g3 (game-player-set-move g2 p1 3))   
(define g4 (game-player-set-move g3 p2 5))   
(define g5 (game-player-set-move g4 p1 0))   
(define g6 (game-player-set-move g5 p2 4))    
(define g7 (game-player-set-move g6 p1 1))   


(display "¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)

(display "¿Se puede jugar después de 7 movimientos? ")
(board-can-play? (game-get-board g7))

(display "Jugador actual después de 7 movimientos: ")
(game-get-current-player g7)

(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g7))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g7))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g7))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g7))

(display "¿Es empate? ")
(game-is-draw? g7)


(define ended-game (game-set-end g7))


(display "Historial de movimientos: ")
(game-history g7)


(display "Estado final del tablero: ")
(game-get-board ended-game)


(display "Creación de 3 nuevos jugadores: ")
(define p3 (player 1 "Williams" "red" 1 0 0 10))
p3
(newline)
(define p4 (player 1 "Fernando" "yellow" 0 1 0 10))
p4
(newline)
(define p5 (player 1 "Cristiano" "red" 1 0 1 21))
p5
(define p6 (player 1 "Alexis" "yellow" 0 1 1 21))
p6

(newline)

(display "Creación de 3 nuevos piezas: ")
(define red-piece2 (piece "red"))
red-piece2
(newline)
(define red-piece3 (piece "yellow"))
red-piece3
(newline)
(define red-piece4 (piece "red"))
red-piece4

(display "Creación de 3 nuevos tableros vacios: ")

(define empty-board2 (board))
empty-board2
(newline)
(define empty-board3 (board))
empty-board3
(newline)
(define empty-board4 (board))
empty-board4

(display "Se puede jugar en la jugadas 0, 2 y 3?? : ")
(board-can-play? (game-get-board g0))
(board-can-play? (game-get-board g2))
(board-can-play? (game-get-board g3))


(display "Agregando fichas en tableros  : ")
(define updated-board (board-set-play-piece empty-board2 2 red-piece))
(define updated-board2 (board-set-play-piece empty-board3 5 red-piece))
(define updated-board3 (board-set-play-piece empty-board4 6 red-piece))

(display "Verificando victorias verticales : ")
(board-check-vertical-win (game-get-board g1))
(board-check-vertical-win (game-get-board g4))
(board-check-vertical-win (game-get-board g5))

(display "Verificando victorias horizontales : ")
(board-check-horizontal-win(game-get-board g1))
(board-check-horizontal-win (game-get-board g3))
(board-check-horizontal-win (game-get-board g5))

(display "Verificando victorias diagonales: ")
(board-check-diagonal-win (game-get-board g1))
(board-check-diagonal-win (game-get-board g2))
(board-check-diagonal-win (game-get-board g5))

(display "Verificando ganador: ")

(board-who-is-winner (game-get-board g2))
(board-who-is-winner (game-get-board g4))
(board-who-is-winner (game-get-board g6))

(display "Creando nuevos juegos: ")
(define new-game (game p1 p2 empty-board 1))
new-game
(newline)
(define new-game2 (game p3 p4 empty-board2 1))
new-game2
(newline)
(define new-game3 (game p5 p6 empty-board3 1))
new-game3

(display "Historial de juego: ")

(newline)
(display "Historial de movimientos de primera, segunda y tercera jugada: ")
(game-history g1)
(newline)
(game-history g2)
(newline)
(game-history g3)

(display "Juego es empate? en jugada 0, 2 y 5 ")
(game-is-draw? g0)
(game-is-draw? g2)
(game-is-draw? g5)


(display "Actualizando jugadaores con sus wins o derrotas a tiffany se le suma 1 win, a christofper una derrota, a Williams una victoria  ")
(define updated-playerp1 (player-update-stats p1 "win"))
updated-playerp1
(newline)
(define updated-playerp2 (player-update-stats p2 "loss"))
updated-playerp2
(newline)
(define updated-playerp3 (player-update-stats p3 "win"))
updated-playerp3

(define ended-game1 (game-set-end g5))
(game-get-current-player g1)
(game-get-current-player g5)
(game-get-current-player g5)


(define ended-game2 (game-set-end g4))
(define ended-game3 (game-set-end g5))
(define ended-game4 (game-set-end g6))



(define updated-game (game-player-set-move g1 p2 1))

(define updated-game2 (game-player-set-move g2 p1 1))
(define updated-game3 (game-player-set-move g5 p2 3))
