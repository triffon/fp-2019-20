#lang racket
(require rackunit)
(require "describe.rkt")

(display "=== b - 1 ===\n")

(describe sum-digit-divisors
  (check-equal? (sum-digit-divisors 46) 0)
  (check-equal? (sum-digit-divisors 52) 2)
  (check-equal? (sum-digit-divisors 222) 6)
  (check-equal? (sum-digit-divisors 123) 4)
  (check-equal? (sum-digit-divisors 3210) 6)
  (check-equal? (sum-digit-divisors 76398743) 0))

(describe same-sum
  (check-equal? (same-sum 42 42) 0)
  (check-equal? (same-sum 28 35) 2)
  (check-equal? (same-sum 1 30) 57))


(display "\n=== b - 2 ===\n")

(define (prod* l) (apply * l))
(define (sum* l) (apply + l))

(describe best-metric?
  (check-equal? (best-metric? (list sum* prod*)
                              '((0 1 2) (3 -4 5) (1337 0)))
                #t)
  (check-equal? (best-metric? (list car sum*)
                              '((100 -100) (29 1) (42)))
                #f))

(display "\n=== b - 3 ===\n")

(describe deep-delete
    (check-equal? (deep-delete '()) '())
    (check-equal? (deep-delete '(())) '(())) ; the tricky test
    (check-equal? (deep-delete '(1 (2 (2 4) 1) 0 (3 (1))))
                  '(1 (2 (4)) (3 ()))))
