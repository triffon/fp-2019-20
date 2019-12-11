(load "./stream.scm")

(define (cycle l)
  (if (null? l)
      empty-stream
      (cons-stream (car l)
                   (cycle (append (cdr l)
                                  (list (car l)))))))

(load "../testing/check.scm")

(check (stream->list (take-stream 5 (cycle '()))) => '())
(check (stream->list (take-stream 5 (cycle '(1)))) => '(1 1 1 1 1))
(check (stream->list (take-stream 3 (cycle '(6)))) => '(6 6 6))
(check (stream->list (take-stream 2 (cycle '(1 2 3)))) => '(1 2))
(check (stream->list (take-stream 5 (cycle '(1 2 3)))) => '(1 2 3 1 2))
(check (stream->list (take-stream 7 (cycle '(1 2 3)))) => '(1 2 3 1 2 3 1))

(check-report)
(check-reset!)
