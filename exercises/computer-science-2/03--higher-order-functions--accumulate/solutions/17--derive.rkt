#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 17
; Напишете функция `(derive f dx)` която връща производната на f.

(define (derive f dx)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x))
       dx)))


(define (sq x) (* x x))

(run-tests (test-suite "derive tests"
             (check-= ((derive sq 0.0001) 2)
                      4
                      0.001))
           'verbose)

