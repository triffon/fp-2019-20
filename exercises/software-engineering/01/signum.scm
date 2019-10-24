(define (signum x)
  (cond ((< x 0) -1)
        ((> x 0) 1)
        (else 0)))

(load "../testing/check.scm")

(check (signum 0) => 0)
(check (signum 1) => 1)
(check (signum 42) => 1)
(check (signum -2) => -1)
(check (signum -123) => -1)

(check-report)
(check-reset!)
