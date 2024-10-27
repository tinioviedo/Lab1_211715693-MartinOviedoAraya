#lang racket
(provide (all-defined-out))


;Descripcion: Crear una lista llamada piece a partir del color
;Dominio: color (string)
;Recorrido : piece
;Constructor
(define (piece color)
  (if (or (equal? color "red")          
          (equal? color "yellow"))
      (list color)
      (error "Formato inválido de parámetro de piece, por favor ingrese 'red' o 'yellow'")))
  


