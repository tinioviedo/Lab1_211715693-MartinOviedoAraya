#lang racket

(provide (all-defined-out))

(require "TDApiece_211715693_MartinOviedo.rkt")


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
;;función auxilar para board-can-play?
;Descripción: Obtiene el elemento en una posición específica de una fila
;Dominio: row position
;Recorrido: el elemento en la posición especifica
(define (get-element-at-position row position)
  (cond
    [(= position 0)(first-at-list row)]
    [else
     (get-element-at-position (rest-at-list row)(- position 1))]))
;;función auxilar para board-can-play?
;Descripción: Obtiene los elementos de una columna específica del tablero.
;Dominio: board column-position
;Recorrido: lista con los elementos de la columna especificada

(define (get-column board column-position)
  (if (null? board)
      '()
      (cons (get-element-at-position (first-at-list board) column-position)
            (get-column (rest-at-list board) column-position))))

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
  ; Función auxiliar para obtener elemento en una posición específica
  (define (get-element-at-position col pos)
    (cond
      [(= pos 0) (first-at-list col)]
      [else (get-element-at-position (rest-at-list col) (- pos 1))]))
  
;función auxiliar que busca el 0 más bajo
(define (aux column column-position)
    (if (negative? column-position)
        #f ; si no encuentra 0
        (if (equal? (get-element-at-position column column-position) 0)
            column-position ; si encuentra cero, devuelve posición
            (aux column (- column-position 1)))))
  
  (aux column (- 6 1)))

;actualizar la fila
(define (update-row current-row column-position piece)
  (cond
    [(= column-position 0) (cons (first-at-list piece) (rest-at-list current-row))]
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
;;función auxiliar mylength
(define (mylength lst)
  (if (null? lst)
      0
      (+ 1 (mylength (rest-at-list lst)))))

;Descripción: Verifica si hay 4 fichas consecutivas del mismo color en una columna
;Dominio: list (columna)
;Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
(define (column-check-vertical column)
  (cond
    [(< (mylength column) 4) 0]  ; si mientras va avanzando , se encuentra que el largo de la columna es menor a 4, ya no puede haber ganador, es empate en la columna
    [(and (not (equal? (first-at-list column) 0))  ;not equal asegura que el primer elemento de la columna no sea 0
          (equal? (first-at-list column) (second-at-list column))  ;1ra y 2da iguales
          (equal? (second-at-list column) (third-at-list column))  ;2da y tra iguales
          (equal? (third-at-list column) (fourth-at-list column))) ;3ra y 4ta iguales, se cumple las 4 seguidas
     (if (equal? (first-at-list column) "r") 1 2)]  ; con lo de arriba me aseguro que hay un ganador , con esto veo quien ganó: 1 para rojo, 2 para amariillo
    [else
     (column-check-vertical (rest-at-list column))])) ;si en los primeros 4 no encontró , revisa los sgtes elementos

;Descripción: Verifica todas las columnas del tablero buscando una victoria vertical
;Dominio: board
;Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
(define (board-check-vertical-win board)
    (cond
      [(> (column-check-vertical (get-column2 board 0)) 0)
       (column-check-vertical (get-column2 board 0))]
      [(null? (rest-at-list (first-at-list board))) 0]
      [else
       (board-check-vertical-win (mymap rest-at-list board))]))
;-rf8
;Descripción: Verifica si hay 4 fichas consecutivas del mismo color en una fila
;Dominio: list (fila)
;Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
(define (row-check-horizontal row)
  (cond
    [(< (mylength row) 4) 0]  ; si el largo de la fila es menor a 4, no puede haber ganador
    [(and (not (equal? (first-at-list row) 0))  ; not equal? asegura que el primer elemento de la columna no sea 0
          (equal? (first-at-list row) (second-at-list row))  
          (equal? (second-at-list row) (third-at-list row))  
          (equal? (third-at-list row) (fourth-at-list row))) 
     (if (equal? (first-at-list row) "r") 1 2)]  ; 1 para rojo, 2 para amarillo
    [else
     (row-check-horizontal (rest-at-list row))]))  ; revisa el siguiente grupo de 4

;Descripción: Verifica todas las filas del tablero buscando una victoria horizontal
;Dominio: board
;Recorrido: number (0 si no hay ganador, 1 si gana rojo, 2 si gana amarillo)
(define (board-check-horizontal-win board)
  (cond
    [(null? board) 0]  ; revisaron todas las filas y nadie ganó
    [else 
     (define row-winner (row-check-horizontal (first-at-list board)))
     (if (> row-winner 0)
         row-winner  ; ganador
         (board-check-horizontal-win (rest-at-list board)))]))  ; revisa la siguiente fila

;rf9-otros
;Descripción: Avanza n posiciones en una lista
;Dominio: list X number 
;Recorrido: list 
;Recursión: Natural
(define (mylist-tail lst n)
  (if (= n 0)
      lst
      (mylist-tail (rest-at-list lst) (- n 1))))

;Descripción: get element en simples palabras es si se quiere un elemento en la fila 4 y columna 3 la función obtienendo la columna 3 en su totalidad y luego avanza( se va hacia abajo) 4 posiciones para obtener el elemento con first-at-list
;Función para obtener un elemento en específico usando get-column2, tomando como dominio la fila y columna
(define (get-element board row col)
  (first-at-list (mylist-tail (get-column2 board col) row))) ;el uso de mylist-tail es para ir avanzando "row" (numero de filas) veces la columa , luego con first-at-list obtenemos el primer elemento de esa lista 
;Verificar si cuatro elementos son iguales y distintos de 0
(define (check-four-equal? e1 e2 e3 e4)
  (and (not (equal? e1 0))
       (equal? e1 e2)
       (equal? e2 e3)
       (equal? e3 e4)))


; Verificar diagonal descendente desde una posición
(define (check-position-descendent board row col)
  (cond
    [(and (<= (+ row 3) 5) (<= (+ col 3) 6))
     (if (check-four-equal?
          (get-element board row col)
          (get-element board (+ row 1) (+ col 1))
          (get-element board (+ row 2) (+ col 2))
          (get-element board (+ row 3) (+ col 3)))
         (if (equal? (get-element board row col) "red") 1 2)
         0)]
    [else
     0]))

; Verificar diagonal ascendente desde una posición
(define (check-position-ascending board row col)
  (cond
    [(and (>= (- row 3) 0) (<= (+ col 3) 6))
     (if (check-four-equal?
          (get-element board row col)
          (get-element board (- row 1) (+ col 1))
          (get-element board (- row 2) (+ col 2))
          (get-element board (- row 3) (+ col 3)))
         (if (equal? (get-element board row col) "red") 1 2)
         0)]
    [else
     0]))

;Descripción: La función debe verificar si hay 4 fichas consecutivas del mismo color en cualquier diagonal (ascendente o descendente).
;Dominio: board
;Recorrido: int (1 si gana jugador 1 (rojo) , 2 si gana jugador 2, 0 si no hay ganador vertical)
(define (board-check-diagonal-win board)
  (define (check-diagonal board row col)
    (cond
      [(>= col 7) 0]
      [(>= row 6) (check-diagonal board 0 (+ col 1))]
      [else
       (define result-desc (check-position-descendent board row col))
       (define result-asc (check-position-ascending board row col))
       (cond
         [(> result-desc 0) result-desc]
         [(> result-asc 0) result-asc]
         [else
          (check-diagonal board (+ row 1) col)])]))
  
  (check-diagonal board 0 0))


;Descripción: Verifica el estado actual del tablero y entrega el ganador que cumple con la regla 
;de conectar 4 fichas de cualquier forma (vertical, horizontal o diagonal)
;Dominio: board
;Recorrido: int (1 si gana el color rojo, 2 si gana el color amarillo, 0 si no hay ganador)
(define (board-who-is-winner board)
  (cond
    [(> (board-check-vertical-win board) 0) (board-check-vertical-win board)]
    [(> (board-check-horizontal-win board) 0) (board-check-horizontal-win board)]
    [(> (board-check-diagonal-win board) 0) (board-check-diagonal-win board)]
    [else
     0]))

;-----







