#lang racket
(require rackunit rackunit/text-ui)

(provide product)

; ### Задача 4
; Напишете функция `(product a b term next)`,
; която изчислява произведението на числата
; `(term a)`, `(term (next a))`, `(term (next (next a)))`, ..., `(term b)`.

(define (product a b term next)
  (if (> a b)
      1
      (* (term a) (product (next a) b term next))))


(define (1+ n) (+ 1 n))
(define (2+ n) (+ 2 n))
(define (sq x) (* x x))

(run-tests (test-suite "product tests"
             (check-eq? (product 1 5 sq 1+)
                        14400)
             (check-eq? (product 1 5 sq 2+)
                        225)
             (check-eq? (product 1 5 (lambda (x) (expt x 3)) 1+)
                        1728000)
             (check-eq? (product 1 5 (lambda (x) (expt x 3)) 2+)
                        3375))
           'verbose)

