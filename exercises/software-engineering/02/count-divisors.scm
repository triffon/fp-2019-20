(define (divides? k n)
  (= (remainder n k) 0))

(define (count-divisors n)
  (define (count-divisors-up-to k)
    (cond ((= k 0) 0)
          ((divides? k n)
           (+ 1 (count-divisors-up-to (- k 1))))
          (else (count-divisors-up-to (- k 1)))))

  (count-divisors-up-to n))

(define (count-divisors-iter n)
  (define (iter count k)
    (cond ((> k n) count)
          ((divides? k n)
           (iter (+ count 1) (+ k 1)))
          (else (iter count (+ k 1)))))

  (iter 0 1))

(load "../testing/check.scm")

(check (count-divisors 1) => 1) ; 1
(check (count-divisors 3) => 2) ; 1 3
(check (count-divisors 12) => 6) ; 1 2 3 4 6 12
(check (count-divisors 15) => 4) ; 1 3 5 15
(check (count-divisors 19) => 2) ; 1 19
(check (count-divisors 42) => 8) ; 1 2 3 6 7 14 21 42
(check (count-divisors 661) => 2) ; 1 661
(check (count-divisors 666) => 12) ; 1 2 3 6 9 18 37 74 111 222 333 666
(check (count-divisors 1337) => 4) ; 1 7 191 1337
(check (count-divisors 65515) => 4) ; 1 5 13103 65515
(check (count-divisors 1234567) => 4) ; 1 127 9721 1234567

(check (count-divisors-iter 1) => 1) ; 1
(check (count-divisors-iter 3) => 2) ; 1 3
(check (count-divisors-iter 12) => 6) ; 1 2 3 4 6 12
(check (count-divisors-iter 15) => 4) ; 1 3 5 15
(check (count-divisors-iter 19) => 2) ; 1 19
(check (count-divisors-iter 42) => 8) ; 1 2 3 6 7 14 21 42
(check (count-divisors-iter 661) => 2) ; 1 661
(check (count-divisors-iter 666) => 12) ; 1 2 3 6 9 18 37 74 111 222 333 666
(check (count-divisors-iter 1337) => 4) ; 1 7 191 1337
(check (count-divisors-iter 65515) => 4) ; 1 5 13103 65515
(check (count-divisors-iter 1234567) => 4) ; 1 127 9721 1234567

(check-report)
(check-reset!)
