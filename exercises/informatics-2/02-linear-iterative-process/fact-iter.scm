(require rackunit rackunit/text-ui)



(define fact-iter-tests
  (test-suite
   "Tests for fact-iter"

   (check = (fact-iter 0) 1)
   (check = (fact-iter 1) 1)
   (check = (fact-iter 2) 2)
   (check = (fact-iter 3) 6)
   (check = (fact-iter 4) 24)
   (check = (fact-iter 5) 120)
   (check = (fact-iter 6) 720)
   (check = (fact-iter 7) 5040)))

(run-tests fact-iter-tests)
