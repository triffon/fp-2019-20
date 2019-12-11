(load "./stream.scm")

(define (iterate f x)
  (cons-stream x (iterate f (f x))))

(load "../testing/check.scm")

(define (identity x) x)
(define (square x) (* x x))

(check (stream->list (take-stream 5 (iterate identity 42)))
       => '(42 42 42 42 42))
(check (stream->list (take-stream 4 (iterate square 2))) => '(2 4 16 256))
(check (stream->list (take-stream 3 (iterate list 6))) => '(6 (6) ((6))))
(check (stream->list (take-stream 6 (iterate list '())))
       => '(() (()) ((())) (((()))) ((((())))) (((((())))))))

(check-report)
(check-reset!)
