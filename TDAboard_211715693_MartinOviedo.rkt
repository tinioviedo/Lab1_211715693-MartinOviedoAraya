#lang racket

(provide (all-defined-out))

(require "TDApiece_211715693_MartinOviedo.rkt")
(require "TDAplayer_211715693_MartinOviedo.rkt")


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
;Descripción: ve si hay una posición disponible en la primera fila, si se encuentra llena de 1, no puede jugar y retorna f, si hay 0's puede jugar
;Dominio: board (tablero)
;Recorrido: boolean (#t posición disponible, #f posición no disponible)
(define (empty-at-top? board)
  (if (member 0 (first-at-list board))
      #t
      #f))
;funcion auxiliar para board-can-play?
;Descripción: Obtiene los valores de una columna (sirve para leer los 0 o 1 de la columna)
;Dominio: board (tablero) X number (column-position (que corresponde al índice de columna 0-6))
;Recorrido: list (lista con los valores de la columna)
;Recursión: Recursión natural
(define (get-column board column-position)
  (if (null? board)
      '()
      (cons (list-ref (first-at-list board) column-position)(get-column (rest-at-list board) column-position))))

;función auxiliar para board-can-play?
;Descripción: Verifica que una columna cumpla con las reglas del juego
;Dominio: list (lista de valores de una columna)
;Recorrido: boolean (#t cumple, #f no cumple)
(define (valid-column column)
  (cond
    [(null? (rest-at-list column)) #t]  ; es valido
    [(and (= (first-at-list (rest-at-list column)) 0) 
          (or (= (first-at-list column) 1)))
     #f]  ; 1 encima de 0 no es válido
    [else (valid-column (rest-at-list column))]))  ; Sigue verificando el resto


;Descripción: Verifica si todas las columnas son válidas
;Dominio: board X number (índice inicial 0)
;Recorrido: boolean (#t si todas son válidas, #f si no)
(define (check-all-columns board column-position)
  (if (= column-position 7)  ; ya se revisaron todas las columna
      #t
      (and (valid-column (get-column board column-position))
           (check-all-columns board (+ column-position 1)))))


;Descripción: Verifica si se puede realizar una jugada en el tablero
;Dominio: board (tablero)
;Recorrido: boolean (#t si se puede jugar, #f si no se puede jugar)
(define (board-can-play? board)
  (and (check-all-columns board 0)
       (empty-at-top? board)))









       
       
       
     









 
  


