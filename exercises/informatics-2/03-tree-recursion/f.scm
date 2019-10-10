(require rackunit rackunit/text-ui)

; TODO: f

; TODO: f-iter

(define f-tests
  (test-suite
    "Tests for f"

    (check = (f 0) 0)
    (check = (f 1) 1)
    (check = (f 2) 2)
    (check = (f 3) 4)
    (check = (f 4) 11)
    (check = (f 5) 25)
    (check = (f 6) 59)
    (check = (f 7) 142)))

(define f-iter-tests
  (test-suite
    "Tests for f-iter"

    (check = (f-iter 0) 0)
    (check = (f-iter 1) 1)
    (check = (f-iter 2) 2)
    (check = (f-iter 3) 4)
    (check = (f-iter 4) 11)
    (check = (f-iter 5) 25)
    (check = (f-iter 6) 59)
    (check = (f-iter 7) 142)))

(run-tests f-tests)
(run-tests f-iter-tests)
