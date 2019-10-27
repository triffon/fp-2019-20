#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 2
; Напишете функция `(my-exp m x)`,
; която изчислява `m`-тата частична сума на функцията `e^x` в точката `x`.

(define (my-exp m x)
  void)

(run-tests (test-suite "my-exp tests"
             (check-= (my-exp 15 1) (exp 1) 0.0001)
             (check-= (my-exp 15 2) (exp 2) 0.0001)
             (check-= (my-exp 15 6) (exp 6) 0.0001))
           'verbose)

