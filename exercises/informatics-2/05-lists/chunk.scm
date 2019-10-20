(require rackunit rackunit/text-ui)

(define chunk-tests
  (test-suite
    "Tests for chunk"

    (check-equal? (chunk '() 42) '())
    (check-equal? (chunk '(1 2) 3) '((1 2)))
    (check-equal? (chunk '(1 2 3 4 5 6) 2) '((1 2) (3 4) (5 6)))
    (check-equal? (chunk '(1 2 3 4 5 6) 3) '((1 2 3) (4 5 6)))
    (check-equal? (chunk '(1 2 3 4 5 6 7 8) 3) '((1 2 3) (4 5 6) (7 8)))))

(run-tests chunk-tests)
