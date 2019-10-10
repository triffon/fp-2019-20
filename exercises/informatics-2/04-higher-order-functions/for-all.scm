(require rackunit rackunit/text-ui)

; TODO: for-all?

(define for-all?-tests
  (test-suite
    "Tests for for-all?"

    (check-true (for-all? (lambda (x) (> x 0)) 2 98))
    (check-true (for-all? (lambda (x) (< x 0)) -10 -1))
    (check-true (for-all? (lambda (x) (= 0 (* x 0))) -3 15))
    (check-true (for-all? (lambda (x) (= 0 (* x 1))) 2 1))

    (check-false (for-all? (lambda (x) (= x 3)) 1 5))
    (check-false (for-all? (lambda (x) (= x 13)) 1 5))
    (check-false (for-all? (lambda (x) (< x 3)) -5 42))))

(run-tests for-all?-tests)
