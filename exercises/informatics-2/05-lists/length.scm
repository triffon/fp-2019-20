(require rackunit rackunit/text-ui)



(define length-tests
  (test-suite
    "Tests for length"

    (check = (length '()) 0)
    (check = (length '(2)) 1)
    (check = (length '(1 2)) 2)
    (check = (length '(3 4 1)) 3)
    (check = (length '(5 3 5 5)) 4)
    (check = (length '(8 4 92 82 8)) 5)
    (check = (length '(8 4 82 12 31 133)) 6)
    (check = (length (range 0 42)) 42)))

(run-tests length-tests)
