#lang racket

;Descripcion: Crear una lista llamada piece a partir del color
;Dominio: color (string)
;Recorrido : piece
;Constructor
(define (piece color) 
  (if (string? color) ;se realiza una validación del parametro color, este debe ser un string
  (list color)(error "Formato invalido de parametro de piece, ingrese un string"))) 

  


