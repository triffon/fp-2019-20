(require rackunit rackunit/text-ui)

(define (expt-iter base n)
  (define (helper exponent result)
    (if (= exponent 1)
        result
        (helper (- exponent 1) (* result base))))

  (if (< n 1)
      1
      (helper n base)))

(define expt-iter-tests
  (test-suite
   "Tests for expt-iter"

   (check = (expt-iter 2 0) 1)
   (check = (expt-iter 2 1) 2)
   (check = (expt-iter 2 2) 4)
   (check = (expt-iter 3 2) 9)
   (check = (expt-iter 5 3) 125)
   (check = (expt-iter 2 10) 1024)
   (check = (expt-iter -2 10) 1024)
   (check = (expt-iter -2 11) -2048)))

(run-tests expt-iter-tests)
