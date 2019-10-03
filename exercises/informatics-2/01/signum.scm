(require rackunit rackunit/text-ui)



(define signum-tests
  (test-suite
   "Tests for signum"

   (check = (signum 0) 0)
   (check = (signum 1) 1)
   (check = (signum 3) 1)
   (check = (signum -1) -1)
   (check = (signum -3) -1)))

(run-tests signum-tests)
