#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt")

(define (1+ n) (+ 1 n))

(define (fact n)
  (accumulate * 1 1 n (lambda (x) x) 1+))

; ### Задача 14
; Напишете функция, която намира броя вариации на `n` елемента, `k`-ти клас.

(define (variations k n)
  (/ (fact n) (fact (- n k))))

(run-tests (test-suite "variations tests"
             (check-eq? (variations 0 3)
                        1)
             (check-eq? (variations 1 15)
                        15)
             (check-eq? (variations 2 15)
                        210)
             (check-eq? (variations 5 15)
                        360360))
           'verbose)

