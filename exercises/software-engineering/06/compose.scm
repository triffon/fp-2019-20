(define (identity x) x)

(define (compose-two f g)
  (lambda (x)
    (f (g x))))

(define (compose . fns)
  (if (null? fns)
      identity
      (compose-two (car fns)
                   (apply compose (cdr fns)))))

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
