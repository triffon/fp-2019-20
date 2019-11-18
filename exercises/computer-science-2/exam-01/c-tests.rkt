#lang racket
(require rackunit)
(require "describe.rkt")

(display "=== c - 1 ===\n")

(describe sum-common-divisors
  (check-equal? (sum-common-divisors 2 2) 3)
  (check-equal? (sum-common-divisors 4 2) 3)
  (check-equal? (sum-common-divisors 12 6) 12))

(describe greatest-sum
  (check-equal? (greatest-sum 42 42) 0)
  (check-equal? (greatest-sum 24 32) 15)
  (check-equal? (greatest-sum 21 34) 15))


(display "\n=== c - 2 ===\n")

(define (prod* l) (apply * l))
(define (sum* l) (apply + l))

(describe count-metrics
  (check-equal? (count-metrics (list sum* prod*)
                               '((0 1 2) (3 0 5) (1337 0)))
                1)
  (check-equal? (count-metrics (list car sum*)
                               '((42 -2 2) (42 0) (42)))
                2))

(display "\n=== c - 3 ===\n")

(describe level-flatten
  (check-equal? (level-flatten '()) '())
  (check-equal? (level-flatten '(())) '())
  (check-equal? (level-flatten '(1 (2 3) 4 (5 (6)) (7)))
                '(2 4 5 5 7 9 9))
  (check-equal? (level-flatten '(1 (2 (2 4) 1) 0 (3 (1))))
                '(2 4 5 7 3 1 5 4)))
