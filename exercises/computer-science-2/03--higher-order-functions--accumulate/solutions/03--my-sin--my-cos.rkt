#lang racket
(require rackunit rackunit/text-ui)

(provide my-sin my-cos)

(require "01--sum.rkt")

(define (1+ n) (+ 1 n))

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

; ### Задача 3
; Подобно на задача 2, направете функции `(my-sin m x)` и `(my-cos m x)`,
; които изчисляват `m`-тите частични суми на `sin(x)` и `cos(x)`.

(define (my-sin m x)
  (sum 0
       m
       (lambda (i) (/ (* (expt -1 i)
                         (expt x (1+ (* 2 i))))
                      (fact (1+ (* 2 i)))))
       1+))
                      

(define (my-cos m x)
  (sum 0
       m
       (lambda (i) (/ (* (expt -1 i)
                         (expt x (* 2 i)))
                      (fact (* 2 i))))
       1+))

(run-tests (test-suite "tests"
             (test-suite "my-sin tests"
               (check-= (my-sin 15 1) (sin 1) 0.0001)
               (check-= (my-sin 15 2) (sin 2) 0.0001)
               (check-= (my-sin 15 6) (sin 6) 0.0001))
             (test-suite "my-cos tests"
               (check-= (my-cos 15 1) (cos 1) 0.0001)
               (check-= (my-cos 15 2) (cos 2) 0.0001)
               (check-= (my-cos 15 6) (cos 6) 0.0001)))
           'verbose)

