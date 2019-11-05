#lang racket
(require rackunit rackunit/text-ui)

(require "01--sum.rkt")

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(define (1+ n) (+ 1 n))

; ### Задача 2
; Напишете функция `(my-exp m x)`,
; която изчислява `m`-тата частична сума на функцията `e^x` в точката `x`.

(define (my-exp m x)
  (if (< m 0)
      0
      (+ (/ (expt x m) (fact m))
         (my-exp (- m 1) x))))

(define (my-exp* m x)
  (sum 0
       m
       (lambda (i) (/ (expt x i) (fact i)))
       1+))

(run-tests (test-suite "my-exp tests"
             (check-= (my-exp 25 1) (exp 1) 0.0001)
             (check-= (my-exp 25 2.) (exp 2) 0.0001)
             (check-= (my-exp 25 6.) (exp 6) 0.0001))
           'verbose)

