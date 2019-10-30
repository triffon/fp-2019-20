(require rackunit rackunit/text-ui)

; Единствената разлика с count-digits е в изчисляването на новия result.

(define (sum-digits n)
  (define (helper counter result)
    (if (= counter 0)
        result
        (helper (quotient counter 10)
                (+ result
                   (remainder counter 10)))))
  (helper n 0))

(define sum-digits-tests
  (test-suite
   "Tests for sum-digits"

   (check = (sum-digits 3) 3)
   (check = (sum-digits 12) 3)
   (check = (sum-digits 42) 6)
   (check = (sum-digits 666) 18)
   (check = (sum-digits 1337) 14)
   (check = (sum-digits 65510) 17)
   (check = (sum-digits 8833443388) 52)
   (check = (sum-digits 100000000000) 1)))

(run-tests sum-digits-tests)
