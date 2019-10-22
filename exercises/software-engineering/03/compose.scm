

(load "../testing/check.scm")

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(check ((compose identity identity) 0) => 0)
(check ((compose identity 1+) 0) => 1)
(check ((compose 1+ identity) 0) => 1)
(check ((compose 1+ 1+) 0) => 2)
(check ((compose square square) 2) => 16)
(check ((compose square 1+) 6) => 49)
(check ((compose 1+ square) 6) => 37)
(check ((compose (compose square 1+) 1+) 6) => 64)

(check-report)
(check-reset!)
