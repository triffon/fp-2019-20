(define (divides? k n)
  (= (remainder n k) 0))

(define (sum-divisors n)
  (define (sum-divisors-up-to k)
    (cond ((= k 0) 0)
          ((divides? k n)
           (+ k (sum-divisors-up-to (- k 1))))
          (else (sum-divisors-up-to (- k 1)))))

  (sum-divisors-up-to n))

(define (sum-divisors-iter n)
  (define (iter sum k)
    (cond ((> k n) sum)
          ((divides? k n)
           (iter (+ sum k) (+ k 1)))
          (else (iter sum (+ k 1)))))

  (iter 0 1))

(load "../testing/check.scm")

(check (sum-divisors 1) => 1) ; 1
(check (sum-divisors 3) => 4) ; 1 3
(check (sum-divisors 12) => 28) ; 1 2 3 4 6 12
(check (sum-divisors 15) => 24) ; 1 3 5 15
(check (sum-divisors 19) => 20) ; 1 19
(check (sum-divisors 42) => 96) ; 1 2 3 6 7 14 21 42
(check (sum-divisors 661) => 662) ; 1 661
(check (sum-divisors 666) => 1482) ; 1 2 3 6 9 18 37 74 111 222 333 666
(check (sum-divisors 1337) => 1536) ; 1 7 191 1337
(check (sum-divisors 65515) => 78624) ; 1 5 13103 65515
(check (sum-divisors 1234567) => 1244416) ; 1 127 9721 1234567

(check (sum-divisors-iter 1) => 1) ; 1
(check (sum-divisors-iter 3) => 4) ; 1 3
(check (sum-divisors-iter 12) => 28) ; 1 2 3 4 6 12
(check (sum-divisors-iter 15) => 24) ; 1 3 5 15
(check (sum-divisors-iter 19) => 20) ; 1 19
(check (sum-divisors-iter 42) => 96) ; 1 2 3 6 7 14 21 42
(check (sum-divisors-iter 661) => 662) ; 1 661
(check (sum-divisors-iter 666) => 1482) ; 1 2 3 6 9 18 37 74 111 222 333 666
(check (sum-divisors-iter 1337) => 1536) ; 1 7 191 1337
(check (sum-divisors-iter 65515) => 78624) ; 1 5 13103 65515
(check (sum-divisors-iter 1234567) => 1244416) ; 1 127 9721 1234567

(check-report)
(check-reset!)
