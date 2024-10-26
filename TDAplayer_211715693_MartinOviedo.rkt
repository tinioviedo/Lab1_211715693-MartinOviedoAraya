#lang racket
(provide (all-defined-out))

;descripcion: Crear una lista llamada Player a partir del Id, name, color, wins, losses, draws, remaining-pieces.
;Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
;Recorrido : player (list)
;Constructor


(define ( player id name color wins losses draws remaining-pieces)
  (if (and (integer? id) ;se realizan validaciones de parametros
           (string? name)
           (string? color)
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

 


 

  
  
                 
                
  