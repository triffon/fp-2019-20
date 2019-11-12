

(load "../testing/check.scm")

(define (identity x) x)
(define (inc x) (+ x 1))
(define (double x) (* 2 x))
(define (square x) (* x x))

(check ((compose) 3) => 3)
(check ((compose square) 3) => 9)
(check ((compose identity square) 3) => 9)
(check ((compose double square inc) 3) => 32)
(check ((compose double square inc) 4) => 50)

(check-report)
(check-reset!)
