#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt")

(define (1+ n) (+ 1 n))

(define (fact n)
  (accumulate * 1 1 n (lambda (x) x) 1+))

; ### Задача 13
; Напишете функция, която намира броя комбинации на `n` елемента, `k`-ти клас.

(define (n-choose-k n k)
  (/ (fact n) (fact k) (fact (- n k))))

(run-tests (test-suite "n-choose-k tests"
             (check-eq? (n-choose-k 15 0)
                        1)
             (check-eq? (n-choose-k 15 15)
                        1)
             (check-eq? (n-choose-k 15 5)
                        3003)
             (check-eq? (n-choose-k 20 1)
                        20)
             (check-eq? (n-choose-k 49 6)
                        13983816))
           'verbose)

