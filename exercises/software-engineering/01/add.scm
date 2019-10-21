(define (add x y)
  (+ x y))

(load "../testing/check.scm")

(check (add 1 2) => 2)
(check (add 1 1) => 2)
(check (add 0 1) => 1)
(check (add -1 2) => 1)
(check (add -2 1) => -1)
(check (add -24 -32) => -56)

(check-report)
(check-reset!)
