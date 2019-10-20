(require rackunit rackunit/text-ui)



(define sum-tests
  (test-suite
    "Tests for sum"

    (check = (sum '()) 0)
    (check = (sum '(2)) 2)
    (check = (sum '(1 2)) 3)
    (check = (sum '(3 4 1)) 8)
    (check = (sum '(5 3 5 5)) 18)
    (check = (sum '(8 4 92 82 8)) 194)
    (check = (sum '(8 4 82 12 31 133)) 270)
    (check = (sum (range 1 11)) 55)))

(run-tests sum-tests)
