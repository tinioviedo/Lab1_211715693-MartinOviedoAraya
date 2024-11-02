#lang racket
(require "TDApiece_21171569_OviedoAraya.rkt")
(require "TDAplayer_21171569_OviedoAraya.rkt")
(require "TDAboard_21171569_OviedoAraya.rkt")
(require "TDAgame_21171569_OviedoAraya.rkt")

(define p1 (player 1 "Matias" "red" 5 2 1 21))     
(define p2 (player 2 "Claudia" "yellow" 2 5 1 21)) 
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
(define empty-board (board))
(define g0 (game p1 p2 empty-board 1))


(define g1 (game-player-set-move g0 p1 6))    
(define g2 (game-player-set-move g1 p2 6))   
(define g3 (game-player-set-move g2 p1 6))   
(define g4 (game-player-set-move g3 p2 6))  
(define g5 (game-player-set-move g4 p1 6))    
(define g6 (game-player-set-move g5 p2 6))    


(define g7 (game-player-set-move g6 p1 1))    
(define g8 (game-player-set-move g7 p2 3))    
(define g9 (game-player-set-move g8 p1 2))    
(define g10 (game-player-set-move g9 p2 3))   
(define g11 (game-player-set-move g10 p1 4))  
(define g12 (game-player-set-move g11 p2 3))  
(define g13 (game-player-set-move g12 p1 5))  
(define g14 (game-player-set-move g13 p2 3))  

(display "¿Se puede jugar en el tablero vacío? ")
(board-can-play? empty-board)
(newline)

(display "¿Se puede jugar después de 2 movimientos? ")
(board-can-play? (game-get-board g2))
(newline)
(display "Jugador actual después de 4 movimientos: ")
(game-get-current-player g4)
(newline)
(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g14))
(newline)
(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g14))
(newline)
(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g14))
(newline)
(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g14))
(newline)
(display "¿Es empate? ")
(game-is-draw? g14)
(newline)
(define ended-game (game-set-end g14))

(newline)
(display "Historial de movimientos de tercera, cuarta y ultima jugada: ")
(game-history g3)
(newline)
(game-history g4)
(newline)
(game-history g14)


(display "Estado final del tablero: ")
(game-get-board ended-game)


(display "Creación de 3 nuevos jugadores: ")
(define p3 (player 1 "Juan" "red" 1 0 0 10))
p3
(newline)
(define p4 (player 1 "Lilian" "yellow" 0 1 0 10))
p4
(newline)
(define p5 (player 1 "Jose" "red" 0 0 0 21))
p5
(define p6 (player 1 "Luna" "yellow" 0 0 0 21))
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

(display "Se puede jugar en la jugadas 1, 4 y 7?? : ")
(board-can-play? (game-get-board g1))
(board-can-play? (game-get-board g4))
(board-can-play? (game-get-board g7))


(display "Agregando fichas en tableros  : ")
(define updated-board (board-set-play-piece empty-board2 1 red-piece))
(define updated-board2 (board-set-play-piece empty-board3 2 red-piece))
(define updated-board3 (board-set-play-piece empty-board4 4 red-piece))

(display "Verificando victorias verticales : ")
(board-check-vertical-win (game-get-board g1))
(board-check-vertical-win (game-get-board g4))
(board-check-vertical-win (game-get-board g7))

(display "Verificando victorias horizontales : ")
(board-check-horizontal-win(game-get-board g1))
(board-check-horizontal-win (game-get-board g4))
(board-check-horizontal-win (game-get-board g7))

(display "Verificando victorias diagonales: ")
(board-check-diagonal-win (game-get-board g1))
(board-check-diagonal-win (game-get-board g4))
(board-check-diagonal-win (game-get-board g7))

(display "Verificando ganador: ")

(board-who-is-winner (game-get-board g1))
(board-who-is-winner (game-get-board g4))
(board-who-is-winner (game-get-board g14))

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
(display "Historial de movimientos de tercera, cuarta y ultima jugada: ")
(game-history g1)
(newline)
(game-history g2)
(newline)
(game-history g3)

(display "Juego es empate? ")
(game-is-draw? g1)
(game-is-draw? g2)
(game-is-draw? g3)


(display "Actualizando jugadaores con sus wins o derrotas a matias se le suma 1 loss, a cludia una victoria, a juan una victoria  ")
(define updated-playerp1 (player-update-stats p1 "loss"))
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



(define updated-game (game-player-set-move g1 p2 3))

(define updated-game2 (game-player-set-move g2 p1 4))
(define updated-game3 (game-player-set-move g5 p2 3))







