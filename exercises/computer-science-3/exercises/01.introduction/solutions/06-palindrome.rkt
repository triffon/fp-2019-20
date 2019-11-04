#lang racket
(require rackunit)
(require rackunit/text-ui)
; 1.7 - Търсим процедура, която проверява дали едно число е палиндром.
; Трябва да работи и за отрицателни числа.

(define (reverse-algo new-number old-number)
  (if (not (= old-number 0))
      (reverse-algo (+  (* 10 new-number) (modulo old-number 10)) (floor (/ old-number 10)))
      new-number
      )
  )

(define (reverse-digits number)
  (if (< number 0)
      (* -1 (reverse-algo 0 (abs number)))
      (reverse-algo 0 number)
  )
)

(define (palindrome? number)
  (= number (reverse-digits number)) ;cool!
)

(define tests (test-suite
  "Palindrome tests"

  (test-case "Should function correctly"
    (check-true (palindrome? 12321))
    (check-false (palindrome? 872))
    (check-true (palindrome? 2))
    (check-true (palindrome? 310013))
    (check-true (palindrome? -21212))
)))

(run-tests tests 'verbose)
