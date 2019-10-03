(require rackunit rackunit/text-ui)



(define add-tests
  (test-suite
   "Tests for add"

   (check = (add 1 2) 3)
   (check = (add 1 1) 2)
   (check = (add 0 1) 1)
   (check = (add 4 -2) 2)
   (check = (add -4 2) -2)))

(run-tests add-tests)
