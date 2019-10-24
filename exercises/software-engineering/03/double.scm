

(load "../testing/check.scm")

(define (1+ x) (+ x 1))
(define (square x) (* x x))

(check ((double 1+) 0) => 2)
(check ((double square) 2) => 16)
(check ((double (double 1+)) 0) => 4)
(check (((double double) 1+) 0) => 4)
(check (((double (double double)) 1+) 0) => 16)
(check (((double (double double)) 1+) 5) => 21)

(check-report)
(check-reset!)
