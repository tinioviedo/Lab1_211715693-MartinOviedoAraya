#lang racket
(provide (all-defined-out))

;--------------Constructor--------------
;Descripcion: Crear una lista llamada piece a partir del color
;para el correcto funcionamiento del juego, el jugador 1 siempre debe usar "red" y el jugador 2 "yellow"
;Dominio: color (string)
;Recorrido : piece
(define (piece color)
  (if (or (equal? color "red")          
          (equal? color "yellow"))
      (list color)
      (error "Formato inválido de parámetro de piece, por favor ingrese 'red' o 'yellow'")))
  


