#lang racket

(require quickcheck
         rackunit
         rackunit/quickcheck)

(require (prefix-in solutions. "../solutions/square-root.rkt"))

(define sqrt-model
  (property ((n (choose-integer 0 100000)))
    (< (abs (- (sqrt n) (solutions.my-sqrt n))) 0.0001)))

(test-case
  "MODEL CHECK: my-sqrt behaves the same as the built in sqrt"
  (with-test-count 1000 (check-property sqrt-model)))
