(require rackunit rackunit/text-ui)



(define scale-tests
  (test-suite
    "Tests for scale"

    (check-equal? (scale '() 42) '())
    (check-equal? (scale '(42) 1) '(42))
    (check-equal? (scale '(1 2 3 4) 2) '(2 4 6 8))
    (check-equal? (scale '(8 4 92 82 8 13) 0) '(0 0 0 0 0 0))
    (check-equal? (scale '(8 4 92 82 8 13) 3) '(24 12 276 246 24 39))))

(run-tests scale-tests)
