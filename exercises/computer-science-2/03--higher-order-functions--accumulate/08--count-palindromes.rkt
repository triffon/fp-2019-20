#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 8
; Напишете функция `(count-palindromes a b)`,
; която намира колко на брой цели числа палиндроми има в интервала [a, b].

(define (count-palindromes a b)
  void)


(run-tests (test-suite "count-palindromes tests"
             (check-eq? (count-palindromes 100 200)
                        10)
             (check-eq? (count-palindromes 1 200)
                        28)
             (check-eq? (count-palindromes 1 10000)
                        198))
           'verbose)

