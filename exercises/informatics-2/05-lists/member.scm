(require rackunit rackunit/text-ui)



(define member?-tests
  (test-suite
    "Tests for member?"

    (check-true (member? '(2) 2))
    (check-true (member? '(1 2) 1))
    (check-true (member? '(1 2) 2))
    (check-true (member? '(8 4 82 12 31 133) 8))
    (check-true (member? '(8 4 82 12 31 133) 4))
    (check-true (member? '(8 4 82 12 31 133) 82))
    (check-true (member? '(8 4 82 12 31 133) 12))
    (check-true (member? '(8 4 82 12 31 133) 31))
    (check-true (member? '(8 4 82 12 31 133) 133))
    (check-true (member? (range 0 42) 33))

    (check-false (member? '() 42))
    (check-false (member? '(2) 1))
    (check-false (member? '(1 2) 3))
    (check-false (member? '(8 4 82 12 31 133) 42))
    (check-false (member? '(8 4 82 12 31 133) 3))
    (check-false (member? '(8 4 82 12 31 133) 1000))
    (check-false (member? (range 0 42) 42))))

(run-tests member?-tests)
