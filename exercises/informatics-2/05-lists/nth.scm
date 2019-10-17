(require rackunit rackunit/text-ui)



(define nth-tests
  (test-suite
    "Tests for nth"

    (check = (nth '(2) 0) 2)
    (check = (nth '(1 2) 0) 1)
    (check = (nth '(1 2) 1) 2)
    (check = (nth '(3 4 1) 0) 3)
    (check = (nth '(3 4 1) 1) 4)
    (check = (nth '(3 4 1) 2) 1)
    (check = (nth '(5 3 5 5) 3) 5)
    (check = (nth '(42 4 82 12 31 133) 4) 31)
    (check = (nth (range 0 43) 32) 32)
    (check = (nth (range 0 43) 42) 42)))

(run-tests nth-tests)
