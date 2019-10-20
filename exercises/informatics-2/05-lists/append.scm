(require rackunit rackunit/text-ui)



(define append-tests
  (test-suite
    "Tests for append"

    (check-equal? (append '() '()) '())
    (check-equal? (append '() '(42)) '(42))
    (check-equal? (append '(42) '()) '(42))
    (check-equal? (append '(42) '(1)) '(42 1))
    (check-equal? (append '(1 2 3 4) '(5 6)) '(1 2 3 4 5 6))
    (check-equal? (append '(1 2 3 4) '(4 4 4)) '(1 2 3 4 4 4 4))
    (check-equal? (append '(8 4 92 82 8 13) '(42 666 83))
                  '(8 4 92 82 8 13 42 666 83))))

(run-tests append-tests)
