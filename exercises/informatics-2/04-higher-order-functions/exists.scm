(require rackunit rackunit/text-ui)

; TODO: exists?

(define exists?-tests
  (test-suite
    "Tests for exists?"

    (check-true (exists? (lambda (x) (= x 3)) 1 5))
    (check-true (exists? (lambda (x) (< x 0)) -3 9))
    (check-true (exists? (lambda (x) (= 0 (* x 0))) -3 15))

    (check-false (exists? (lambda (x) (= x 13)) 1 5))
    (check-false (exists? (lambda (x) (< x 3)) 10 42))
    (check-false (exists? (lambda (x) (< x 0)) 3 8))
    (check-false (exists? (lambda (x) (= 0 (* x 0))) 2 1))))

(run-tests exists?-tests)
