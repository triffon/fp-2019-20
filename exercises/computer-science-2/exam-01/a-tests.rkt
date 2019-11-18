#lang racket
(require rackunit)
(require "describe.rkt")

(display "=== a - 1 ===\n")

(describe product-digits
  (check-equal? (product-digits 2) 2)
  (check-equal? (product-digits 123) 6)
  (check-equal? (product-digits 321) 6)
  (check-equal? (product-digits 3210) 0)
  (check-equal? (product-digits 76398743) 762048))

(describe largest-diff
  (check-equal? (largest-diff 28 28) 0)
  (check-equal? (largest-diff 28 35) 19)
  (check-equal? (largest-diff 31 35) 8))



(display "\n=== a - 2 ===\n")

(define (prod* l) (apply * l))
(define (sum* l) (apply + l))

(describe max-metric
  (check-equal? (max-metric (list sum* prod*)
                            '((0 1 2) (3 4 5) (1337 0)))
                sum*)
  (check-equal? (max-metric (list car sum*)
                            '((1000 -1000) (29 1) (42)))
                car))

(display "\n=== a - 3 ===\n")

(describe deep-repeat
  (check-equal? (deep-repeat '())
                             '())
  (check-equal? (deep-repeat '(((())))) ; tricky corner case
                             '(((()))))
  (check-equal? (deep-repeat '(((6))))
                             '(((6 6 6))))
  (check-equal? (deep-repeat '(1 2 (3) () (() 5) 4))
                             '(1 2 (3 3) () (() 5 5) 4))
  (check-equal? (deep-repeat '((2 3) 4 ((6))))
                             '((2 2 3 3) 4 ((6 6 6))))
  (check-equal? (deep-repeat '(1 (2 3) 4 (5 (6))))
                             '(1 (2 2 3 3) 4 (5 5 (6 6 6)))))
