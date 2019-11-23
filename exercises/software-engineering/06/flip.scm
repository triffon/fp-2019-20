

(load "../testing/check.scm")
(load "./compose.scm")

(define (inc x) (+ x 1))
(define (double x) (* 2 x))
(define (square x) (* x x))

(check ((flip list) 1 2 3) => '(3 2 1))
(check (((flip compose) inc square double) 3) => 32)
(check (((flip compose) inc square double) 4) => 50)

(check-report)
(check-reset!)
