#lang racket
(provide (all-defined-out))
(require "TDApiece_21171569_OviedoAraya.rkt")
(require "TDAplayer_21171569_OviedoAraya.rkt")
(require "TDAboard_21171569_OviedoAraya.rkt")

;--------------Constructor--------------
;RF11
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
      (list player1 player2 board current-turn '())
      (error "Formato invalido de parametro(s) de game")))

;--------------Selectores--------------
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
;Recorrido: board
(define (game-get-board game)
  (third-at-list game))



;--------------Modificadores--------------
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
      (fourth-at-list game)
      (game-history game))]
    
    ;Cuando gana el rojo
    [(= (board-who-is-winner (third-at-list game)) 1)
     (list 
      (player-update-stats (first-at-list game) "win")
      (player-update-stats (second-at-list game) "loss")
      (third-at-list game)
      (fourth-at-list game)
      (game-history game))]
    
    ;cuando gana el amarillo
    [(= (board-who-is-winner (third-at-list game)) 2)
     (list 
      (player-update-stats (first-at-list game) "loss")
      (player-update-stats (second-at-list game) "win")
      (third-at-list game)
      (fourth-at-list game)
      (game-history game))]))




;RF18 

;Descripción: Función que realiza un movimiento en el juego
;Dominio: game X player X int (columna)
;Recorrido: game
(define (game-player-set-move current-game player column)
  (if (not (valid-move? current-game player column))
      (error "Movimiento no válido")
      
      (if (or (> (board-who-is-winner 
                  (board-set-play-piece 
                   (third-at-list current-game) 
                   column 
                   (piece (third-at-list player)))) 0)
              (game-is-draw? current-game))
          
          ;juego terminoó
          (list 
           ;actualizo rojo
           (if (equal? (third-at-list player) "red")
               (update-player-after-move player)
               (first-at-list current-game))
           ;actualizo amarillo
           (if (equal? (third-at-list player) "yellow")
               (update-player-after-move player)
               (second-at-list current-game))
           ;actualizo board
           (board-set-play-piece 
            (third-at-list current-game) 
            column 
            (piece (third-at-list player)))
           ;actualizo turno
           (if (= (fourth-at-list current-game) 1) 2 1)
           ;actualizo historial
           (cons (list column (third-at-list player))
                 (game-history current-game)))
          
          ;juego sigue
          (list 
           ;actualizo rojo
           (if (equal? (third-at-list player) "red")
               (update-player-after-move player)
               (first-at-list current-game))
           ;actualizo amarillo
           (if (equal? (third-at-list player) "yellow")
               (update-player-after-move player)
               (second-at-list current-game))
           ;actualizo board
           (board-set-play-piece 
            (third-at-list current-game) 
            column 
            (piece (third-at-list player)))
           ;actualizo turno
           (if (= (fourth-at-list current-game) 1) 2 1)
           ;actualizo historial
           (cons (list column (third-at-list player))
                 (game-history current-game))))))

;--------------Otros--------------

;rf12 history
;Permite crear un historial de movimientos
;Dominio : game
;Recorrido: game
(define (game-history game)
  (cond [(and (list? game) (>= (mylength game) 5) (list? (fifth-at-list game)))
         (fifth-at-list game)]
        [else
         '()]))



;rf13

;Descripción: Función que verifica si el estado actual del juego es empate
;Dominio: game
;Recorrido: boolean(#t si es empate, #f si no)
(define (game-is-draw? game)
  (and 
   ;si el tablero esta lleno y no ganan
   (not (board-can-play? (third-at-list game)))
   (= 0 (board-who-is-winner (third-at-list game)))))




;-------------Funciones auxiliares-----------

;RF18

;Función auxiliar para game-player-set-move
;Descripción: Verifica movimiento valido
;Dominio: game X player X int
;Recorrido: boolean
(define (valid-move? game player column)
  (and (list? game)                                    
       (list? player)                                  
       (integer? column)                               
       ; con get-column2 verfico si columna es valida
       (not (null? (get-column2 (third-at-list game) column)))
       ; Verificar si se puede jugar en el tablero actual
       (board-can-play? (third-at-list game))
       (> (last-at-list player) 4)
       ;que el turno sea el correcto
       (or (and (= (fourth-at-list game) 1)           
                (equal? (third-at-list player) "red")) 
           (and (= (fourth-at-list game) 2)           
                (equal? (third-at-list player) "yellow")))))

;Función auxiliar para game-player-set-move
;Descripción: disminuye cantidad de fichas del jugador
;Dominio: player
;Recorrido: player
(define (update-player-after-move player)
  (list (first-at-list player)       
        (second-at-list player)    
        (third-at-list player)      
        (fourth-at-list player)     
        (fifth-at-list player)     
        (sixth-at-list player)        
        (- (last-at-list player) 1)))





