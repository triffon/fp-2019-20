(load "./stream.scm")

(define (repeat value)
  (cons-stream value (repeat value)))

(load "../testing/check.scm")

(check (stream->list (take-stream 5 (repeat 1))) => '(1 1 1 1 1))
(check (stream->list (take-stream 3 (repeat 6))) => '(6 6 6))
(check (stream->list (take-stream 6 (repeat '()))) => '(() () () () () ()))
(check (stream->list (take-stream 3 (repeat '(1 2 3))))
       => '((1 2 3) (1 2 3) (1 2 3)))

(check-report)
(check-reset!)
