#lang racket

; 1. reverse
(define (reverse* lst)
  (define (help acc lst)
    (if (null? lst)
      acc
      (help (cons (car lst) acc)
            (cdr lst))))
  (help '() lst))

; 2. foldr
(define (foldr* op acc lst)
  (if (null? lst)
    acc
    (op (car lst)
        (foldr* op acc (cdr lst)))))

; 3. foldl
(define (foldl* op acc lst)
  (if (null? lst)
    acc
    (foldl* op
            (op acc (car lst))
            (cdr lst))))

; 4. length
(define (length** lst)
  (foldl* (lambda (x _) (+ x 1)) 0 lst))

; 5. count-atoms
(define (count-atoms lst)
  (cond [(null? lst) 0]
        [(not (pair? lst)) 1]
        [else (+ (count-atoms (car lst))
                 (count-atoms (cdr lst)))]))

; take и drop не се държат така попринцип в racket,
; а при по-голямо n биха хвърлили грешка.
; В Haskell примерно се държат точно както са написани тук.

; 6. take xs n
(define (take xs n)
  (cond [(zero? n) '()]
        [(> n (length xs)) xs]
        [else (cons
                (car xs)
                (take (cdr xs)
                      (- n 1)))]))

; 7. drop xs n
(define (drop xs n)
  (cond [(zero? n) xs]
        [(> n (length xs)) '()]
        [else (drop (cdr xs) (- n 1))]))

(take '(1 2 3) 5)
(drop '(1 2 3) 5)

; 8. transpose m
(define (transpose m) (apply map list m))

