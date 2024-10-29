#lang racket
(provide (all-defined-out))

(require "TDApiece_211715693_MartinOviedo.rkt")
(require "TDAplayer_211715693_MartinOviedo.rkt")
(require "TDAboard_211715693_MartinOviedo.rkt")

;_---------------------------------NUEVO TDA GAME

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


;Descripción: Función que verifica si el estado actual del juego es empate
;Dominio: game
;Recorrido: boolean(#t si es empate, #f si no)
(define (game-is-draw? game)
  
  
                       
                    

