(require rackunit rackunit/text-ui)

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define accumulate-tests
  (test-suite
    "Tests for accumulate"

    (check-equal? (accumulate '() + 0 square) 0)
    (check-equal? (accumulate '(40) + 2 identity) 42)
    (check-equal? (accumulate '(1 2 3 4) + 0 1+) 14)
    (check-equal? (accumulate '(1 2 3 4 5) * 1 square) 14400)
    (check-equal? (accumulate '(8 4 92 82 8 13) * 0 square) 0)))

(run-tests accumulate-tests)
