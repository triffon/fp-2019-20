(require rackunit rackunit/text-ui)



(define count-divisors-tests
  (test-suite
   "Tests for count-divisors"

   (check = (count-divisors 3) 2) ; 1 3
   (check = (count-divisors 12) 6) ; 1 2 3 4 6 12
   (check = (count-divisors 15) 4) ; 1 3 5 15
   (check = (count-divisors 19) 2) ; 1 19
   (check = (count-divisors 42) 8) ; 1 2 3 6 7 14 21 42
   (check = (count-divisors 661) 2) ; 1 661
   (check = (count-divisors 666) 12) ; 1 2 3 6 9 18 37 74 111 222 333 666
   (check = (count-divisors 1337) 4) ; 1 7 191 1337
   (check = (count-divisors 65515) 4) ; 1 5 13103 65515
   (check = (count-divisors 1234567) 4))) ; 1 127 9721 1234567

(run-tests count-divisors-tests)
