#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 9
; Реализирайте функцията `prime?` чрез `accumulate` или `accumulate-i`

(define (prime? n)
  void)

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

