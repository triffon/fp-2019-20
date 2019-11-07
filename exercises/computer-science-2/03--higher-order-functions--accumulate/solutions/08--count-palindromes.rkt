#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt"
         "../../02--recursive-and-iterative-processes/solutions/04--palindrome.rkt")

(define (1+ n) (+ 1 n))

; ### Задача 8
; Напишете функция `(count-palindromes a b)`,
; която намира колко на брой цели числа палиндроми има в интервала [a, b].

(define (count-palindromes a b)
  (accumulate + 0 a b
              (lambda (x)
                (if (palindrome? x) 1 0))
              1+))


(run-tests (test-suite "count-palindromes tests"
             (check-eq? (count-palindromes 100 200)
                        10)
             (check-eq? (count-palindromes 1 200)
                        28)
             (check-eq? (count-palindromes 1 10000)
                        198))
           'verbose)

