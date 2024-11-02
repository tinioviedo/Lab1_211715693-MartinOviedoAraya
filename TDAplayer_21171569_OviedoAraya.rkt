#lang racket
(provide (all-defined-out))

(require "TDApiece_21171569_OviedoAraya.rkt")
(require "TDAboard_21171569_OviedoAraya.rkt")

;--------------Constructor--------------
;RF O2
;Descripcion: Crear una lista llamada Player a partir del Id, name, color, wins, losses, draws, remaining-pieces.
;Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
;Recorrido : player (list)


(define ( player id name color wins losses draws remaining-pieces)
  (if (and (integer? id) ;se realizan validaciones de parametros
           (string? name)
           (or (equal? color "red")   
               (equal? color "yellow"))
           (and (integer? wins)
                (>= wins 0))
           (and (integer? losses)
                (>= losses 0))
           (and (integer? draws)
                (>= draws 0))
           (and (integer? remaining-pieces)
                (<= remaining-pieces 21)
                (>= remaining-pieces 4)))  ;se debe tener minimo 4 fichas para jugar
      (list id name color wins losses draws remaining-pieces)
      (error "Formato invalido de parametro(s) de player")))


;--------------Otros--------------
;RF 14
;Descripción: Función que actualiza las estadísticas del jugador (victorias, derrotas o empates) después de finalizar un juego.
;Dominio: player (player) X result (string: "win", "loss", o "draw")
;Recorrido: boolean (#t si es empate, #f si no)

(define (player-update-stats player result)
  (if (and (list? player) ; validaciones      
           (= (mylength player) 7)            
           (member result '("win" "loss" "draw"))) ; recibir si o si los casos posibles, si no ,no se ejecut
       ; creación de la nueva lista actualizada
      (list (first-at-list player) (second-at-list player) (third-at-list player) ; el id, nombre y color
       ; luego condicionales ya que si gana, le suma 1 a wins, si pierde, le suma 1 a losses, si empata le suma 1 a draws
       ;wins
       (if (equal? result "win")   
           (+ (fourth-at-list player) 1)    
           (fourth-at-list player))
       
       ;losses
       (if (equal? result "loss")       
           (+ (fifth-at-list player) 1)  
           (fifth-at-list player))     
       
       ;draws
       (if (equal? result "draw")      
           (+ (sixth-at-list player) 1)       
           (sixth-at-list player))

       (last-at-list player))       

      (error "Formato inválido de parámetro(s) de player-update-stats")))


 

  
  
                 
                
  