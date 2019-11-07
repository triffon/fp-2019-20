#lang racket
(require rackunit rackunit/text-ui)

(require "02--sum.rkt")

(define (divides? x y)
  (= (remainder y x) 0))
(define (prime? n)
  (and (>= n 2)
       (let ((rootn (sqrt n)))
         (define (for i)
           (or (> i rootn)
               (and (not (divides? i n))
                    (for (+ 1 i)))))
         (for 2))))


; ### Задача 12
; Напишете функция `(scp L)`,
; която намира сумата на третите степени на всички прости числа в `L`.

(define (scp L)
  (sum (map (lambda (x) (* x x x))
            (filter (lambda (x)
                      (and (real? x) (prime? x)))
                    L))))


(run-tests (test-suite "scp tests"
             (check-equal? (scp '())
                           0)
             (check-equal? (scp '((5 2) (1 3)))
                           0)
             (check-equal? (scp '(1 2 3 4 5))
                           160))
           'verbose)

