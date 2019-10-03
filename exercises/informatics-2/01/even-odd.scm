(require rackunit rackunit/text-ui)



(define even-odd-tests
  (test-suite
   "Tests for even and odd"

   (check-true (even? 0))
   (check-true (even? 2))
   (check-false (even? 1))
   (check-false (even? 3))

   (check-false (odd? 0))
   (check-false (odd? 2))
   (check-true (odd? 1))
   (check-true (odd? 3))))

(run-tests even-odd-tests)
