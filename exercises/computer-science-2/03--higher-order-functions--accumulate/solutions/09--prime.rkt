#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt")

(define (1+ n) (+ 1 n))

; ### Задача 9
; Реализирайте функцията `prime?` чрез `accumulate` или `accumulate-i`

(define (prime? n)
  (and (> n 1)
       (accumulate (lambda (x y) (and x y))
                   #t
                   2
                   (sqrt n)
                   (lambda (k)
                     (not (= (remainder n k) 0)))
                   1+)))


(run-tests (test-suite "prime? tests"
             (check-false (prime? 0))
             (check-false (prime? 1))
             (check-false (prime? -120))
             (check-false (prime? 120))
             (check-true (prime? 2))
             (check-true (prime? 3))
             (check-true (prime? 7))
             (check-true (prime? 101))
             (check-true (prime? 2411)))
           'verbose)

