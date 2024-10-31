#lang racket
(provide (all-defined-out))
(require "TDApiece_211715693_MartinOviedo.rkt")
(require "TDAplayer_211715693_MartinOviedo.rkt")
(require "TDAboard_211715693_MartinOviedo.rkt")

;_---------------------------------NUEVO TDA GAME
;rf11
;Descripción: Función que permite crear una nuevapartida.
;Dominio: player1 (player) X player2 (player) X board (board) X current-turn (int)
;Recorrido: game

(define (game player1 player2 board current-turn)
  (if (and (list? player1)                             ; player1 debe ser lista
           (list? player2)                             ; player2 debe ser lista
           (list? board)                               ; board debe ser lista
           (equal? (third-at-list player1) "red")      ; player1 debe ser rojo
           (equal? (third-at-list player2) "yellow")   ; player2 debe ser amarillo
           (or (= current-turn 1) (= current-turn 2))) ; turno debe ser 1 o 2
      (list player1 player2 board current-turn)
      (error "Formato invalido de parametro(s) de game")))
;rf12 historial
;-------

;rf13
;Descripción: Función que verifica si el estado actual del juego es empate
;Dominio: game
;Recorrido: boolean(#t si es empate, #f si no)
(define (game-is-draw? game)
  (or 
   ;caso del tablero lleno
   (not (board-can-play? (third-at-list game)))
   
   ;caso de los jugadores sin fichas
   (and 
    (= (last-at-list (first-at-list game)) 0)  
    (= (last-at-list (second-at-list game)) 0))))
  
;selectores
;rf 15

;Descripción: Obtener el jugador cuyo turno está en curso
;Dominio: game
;Recorrido: player
(define (game-get-current-player game)
  (if (= (fourth-at-list game) 1)      ; si el turno actual (fourth-at-list) es 1
      (first-at-list game)             ; retorna player1 (first-at-list)
      (second-at-list game)))          ; si no, retorna player2 (second-at-list)

;rf 16
;Descripción: Obtener representación del estado actual del tablero
;Dominio: game
;Recorrido: Board
(define (game-get-board game)
  (third-at-list game))
;rf 17
;Descripción: Función que finaliza el juego actualizando las estadísticas de los jugadores según el resultado
;Dominio: game
;Recorrido: game

(define (game-set-end game)
  (cond
    ;Cuando empatan
    [(game-is-draw? game)
     (list
      (player-update-stats (first-at-list game) "draw")
      (player-update-stats (second-at-list game) "draw")
      (third-at-list game)
      (fourth-at-list game))]
    
    ;Cuando gana el rojo
    [(= (board-who-is-winner (third-at-list game)) 1)
     (list 
      (player-update-stats (first-at-list game) "win")
      (player-update-stats (second-at-list game) "loss")
      (third-at-list game)
      (fourth-at-list game))]
    
    ;cuando gana el amarillo
    [(= (board-who-is-winner (third-at-list game)) 2)
     (list 
      (player-update-stats (first-at-list game) "loss")
      (player-update-stats (second-at-list game) "win")
      (third-at-list game)
      (fourth-at-list game))]))

                    

