(require rackunit rackunit/text-ui)

(define maximum-tests
  (test-suite
    "Tests for maximum"

    (check = (maximum '(2)) 2)
    (check = (maximum '(5 3 5 5)) 5)
    (check = (maximum '(8 4 92 82 8 13)) 92)
    (check = (maximum '(8 4 82 12 31 133)) 133)))

(run-tests maximum-tests)
