#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 12
; Напишете функция `(count-pred pred? a b next)`,
; която намира колко на брой числа удовлетворяват предиката `pred?` сред числата
; `a`, `(next a)`, `(next (next a))`, ..., `b`.

(define (count-pred pred? a b next)
  void)

(define (1+ n) (+ 1 n))
(define (2+ n) (+ 2 n))

(run-tests (test-suite "count-pred tests"
             (check-eq? (count-pred number? 1 5 1+)
                        5)
             (check-eq? (count-pred odd? 1 5 1+)
                        3)
             (check-eq? (count-pred even? 1 5 1+)
                        2)
             (check-eq? (count-pred odd? 1 10 2+)
                        5)
             (check-eq? (count-pred even? 1 10 2+)
                        0))
           'verbose)

