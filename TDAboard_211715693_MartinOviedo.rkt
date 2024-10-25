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
    [(null? (rest-at-list column)) #t]  ; es valido(casobase)
    [(and (equal? (first-at-list (rest-at-list column)) 0) 
          (not (equal? (first-at-list column) 0)))
     #f]  ; valor no-0 encima de 0 no es válido
    [else
     (valid-column (rest-at-list column))]))  ; Sigue verificando el resto


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

;--- RF06
;Función auxiliar mymap
(define mymap (lambda (f l)
                ;caso base
                (if (null? l)
                    '()
                    (cons (f (first-at-list l)) (mymap f (rest-at-list l ))))))

;Otra manera de obtener columnas de una manera no recursiva
(define (get-column2 board column-position)
  (mymap (lambda (row) (list-ref row column-position)) board))


;Encontrar el cero más bajo en la columna
;Descripción: Busca el 0 más bajo de la columna
;Dominio: column
;Recorrido: da la posición del 0 más bajo de la columna
(define (find-zero column)
  (define (aux column column-position)
    (if (negative? column-position)
        #f ; si no encuentra 0
        (if (equal? (list-ref column column-position) 0)
            column-position ; encuentra cero, devuelve posición
            (aux column (- column-position 1))))) ; continúa la búsqueda
  (aux column (- 6 1))) ; comienza desde la última posición (5) para un tablero de 6 filas

;actualizar la fila
(define (update-row current-row column-position piece)
  (cond
    [(= column-position 0) (cons (first-at-list piece) (rest-at-list current-row))]  ; Aquí usamos first-at-list en vez de piece-get-color
    [else
     (cons (first-at-list current-row)
                (update-row (rest-at-list current-row) (- column-position 1) piece))]))

;Descripción: Actualiza el tablero con la nueva fila en la posición especificada.
;Dominio: board (tablero) X number (column-position) X list (nueva fila)
;Recorrido: board (nuevo tablero actualizado)
(define (update-board board column-position new-row)
  (if (= column-position 0)
      (cons new-row (rest-at-list board)) ; Reemplaza la primera fila
      (cons (first-at-list board) 
            (update-board (rest-at-list board) (- column-position 1) new-row)))) ; Reemplaza la fila correspondiente




;Descripción: coloca la ficha en la posición más baja disponible de la columna seleccionada.
;Dominio: board (tablero) X number (column) X piece
;Recorrido: board (tablero actualizado con la nueva ficha)
(define (board-set-play-piece board column piece)
  (update-board board 
   (find-zero (get-column2 board column))
   (update-row 
    (cond 
      [(= (find-zero (get-column2 board column)) 0) (first-at-list board)]
      [(= (find-zero (get-column2 board column)) 1) (second-at-list board)]
      [(= (find-zero (get-column2 board column)) 2) (third-at-list board)]
      [(= (find-zero (get-column2 board column)) 3) (fourth-at-list board)]
      [(= (find-zero (get-column2 board column)) 4) (fifth-at-list board)]
      [(= (find-zero (get-column2 board column)) 5) (sixth-at-list board)])
    column 
    piece)))
;Descripción: TDA BOAR-OTROS-VICTORIA VERTICAL; tengo que ordenar esto

;Descripción: Verifica si hay 4 fichas consecutivas del mismo color en una columna
;Dominio: list (columna)
;Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
(define (column-check-vertical column)
  (cond
    [(< (length column) 4) 0]  ; si mientras va avanzando , se encuentra que el largo de la columna es menor a 4, ya no puede haber ganador, es empate en la columna
    [(and (not (equal? (first-at-list column) 0))  ;not equal asegura que el primer elemento de la columna no sea 0
          (equal? (first-at-list column) (second-at-list column))  ;1ra y 2da iguales
          (equal? (second-at-list column) (third-at-list column))  ;2da y tra iguales
          (equal? (third-at-list column) (fourth-at-list column))) ;3ra y 4ta iguales, se cumple las 4 seguidas
     (if (equal? (first-at-list column) "r") 1 2)]  ; con lo de arriba me aseguro que hay un ganador , con esto veo quien ganó: 1 para rojo, 2 para amariillo
    [else
     (column-check-vertical (rest-at-list column))])) ;si en los primeros 4 no encontró , revisa los sgtes elementos

; Descripción: Verifica todas las columnas del tablero buscando una victoria vertical
; Dominio: board
; Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
;(define (board-check-vertical-win board)