(require rackunit rackunit/text-ui)

(define (sum-iter start end)
  (define (helper counter result)
    (if (> counter end)
        result
        (helper (+ counter 1) (+ result counter))))

  (if (> start end)
      0
      (helper start 0)))

(define sum-iter-tests
  (test-suite
   "Tests for sum-iter"

   (check = (sum-iter 1 1) 1)
   (check = (sum-iter 1 2) 3)
   (check = (sum-iter 1 3) 6)
   (check = (sum-iter 0 4) 10)
   (check = (sum-iter -4 2) -7)))

(run-tests sum-iter-tests)
