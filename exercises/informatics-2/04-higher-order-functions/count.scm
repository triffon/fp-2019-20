(require rackunit rackunit/text-ui)

; TODO: count

(define count-tests
  (test-suite
    "Tests for count"

    (check = (count even? 1 5) 2)
    (check = (count even? 0 10) 6)

    (check = (count odd? 1 5) 3)
    (check = (count odd? 0 10) 5)))

(run-tests count-tests)
