#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt")

(define (1+ n) (+ 1 n))

; ### Задача 7
; Реализирайте функциите `fact`, `sum` и `product` от предишни задачи чрез `accumulate`.

(define (fact n)
  (accumulate * 1 1 n (lambda (i) i) 1+))

(define (sum a b term next)
  (accumulate + 0 a b term next))

(define (product a b term next)
  (accumulate * 1 a b term next))


(define (2+ n) (+ 2 n))
(define (id x) x)
(define (sq x) (* x x))

(run-tests (test-suite "tests"
             (test-suite "factorial tests"
               (check-eq? (fact 0)
                          1)
               (check-eq? (fact 1)
                          1)
               (check-eq? (fact 15)
                          1307674368000)
               (check-eq? (fact 5)
                          120))
             (test-suite "product tests"
               (check-eq? (product 1 5 sq 1+)
                          14400)
               (check-eq? (product 1 5 sq 2+)
                          225)
               (check-eq? (product 1 5 (lambda (x) (expt x 3)) 1+)
                          1728000)
               (check-eq? (product 1 5 (lambda (x) (expt x 3)) 2+)
                          3375))
             (test-suite "sum tests"
               (check-eq? (sum 1 5 id 2+)
                          9)
               (check-eq? (sum 1 6 id 2+)
                          9)
               (check-eq? (sum -5 -1 id 2+)
                          -9)
               (check-eq? (sum 5 1 id 2+)
                          0)
             
               (check-eq? (sum 1 5 sq 1+)
                          55)
               (check-eq? (sum -5 -1 sq 1+)
                          55)
               (check-eq? (sum 5 1 sq 1+)
                          0)
             
               (check-eq? (sum 1 5 sq 2+)
                          35)
               (check-eq? (sum -5 -1 sq 2+)
                          35)
               (check-eq? (sum 5 1 sq 2+)
                          0)))
           'verbose)

