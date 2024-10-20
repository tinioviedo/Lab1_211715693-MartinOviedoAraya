#lang racket

;Descripcion: Crear una lista para representar el tablero, la lista está compuesta de 6 sublistas (filas) en donde cada una tiene 7 elementos que serían las columnas
;Los 0 van a representar que está vacia la posición
;Los 1 van a representar que está ocupada la posición
;Dominio: no hay parametros de entrada
;Recorrido : board (un tablero vacio)
;Constructor

(define (board) 
  (list (list 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0)))

;Definiendo funciones auxiliares que voy a utilizar para acceder a elementos de las listas
(define first-at-list car)   ; Obtiene el primer elemento de una lista
(define second-at-list cadr) ; Obtiene el segundo elemento de una lista
(define third-at-list caddr) ; Obtiene el tercer elemento de una lista
(define fourth-at-list cadddr) ; Obtiene el cuarto elemento de una lista
(define (fifth-at-list lst) (car (cddddr lst))) ; Obtiene el quinto elemento
(define (sixth-at-list lst) (cadr (cddddr lst))) ; Obtiene el sexto elemento
(define last-at-list last)   ; Obtiene el último elemento de una lista
(define rest-at-list cdr)    ; Obtiene el resto de la lista sin el primer elemento

;función auxilar para board-can-play?
;Descripción: ve si hay una posición disponible en la primera fila, si se encuentra con 1, no puede jugar y retorna f, si hay 0 puede jugar
;Dominio: board (tablero)
;Recorrido: boolean (#t posición disponible, #f posición no disponible)
(define (empty-at-top? board)
  (if (member 0 (first-at-list board))
      #t
      #f))

;Descripción: Verifica si se puede realizar una jugada en el tablero
;Dominio: board (tablero)
;Recorrido: boolean (#t si se puede jugar, #f si no se puede jugar)
(define (board-can-play? board)
  (empty-at-top? board))









       
       
       
     









 
  


