(require rackunit rackunit/text-ui)



(define last-tests
  (test-suite
    "Tests for last"

    (check = (last '(2)) 2)
    (check = (last '(1 2)) 2)
    (check = (last '(3 4 1)) 1)
    (check = (last '(5 3 5 5)) 5)
    (check = (last '(42 4 92 82 8)) 8)
    (check = (last '(42 4 82 12 31 133)) 133)
    (check = (last (range 0 43)) 42)))

(run-tests last-tests)
