(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (quotient n 10)))))

(define (reverse-digits n)
  (if (= n 0)
      0
      (+ (* (remainder n 10)
            (expt 10 (- (count-digits n) 1)))
         (reverse-digits (quotient n 10)))))

(define (reverse-digits-iter n)
  (define (iter reversed n)
    (if (= n 0)
        reversed
        (iter (+ (* reversed 10)
                 (remainder n 10))
              (quotient n 10))))

  (iter 0 n))

(load "../testing/check.scm")

(check (reverse-digits 0) => 0)
(check (reverse-digits 3) => 3)
(check (reverse-digits 12) => 21)
(check (reverse-digits 42) => 24)
(check (reverse-digits 666) => 666)
(check (reverse-digits 1337) => 7331)
(check (reverse-digits 65510) => 1556)
(check (reverse-digits 1234567) => 7654321)
(check (reverse-digits 8833443388) => 8833443388)
(check (reverse-digits 100000000000) => 1)

(check (reverse-digits-iter 0) => 0)
(check (reverse-digits-iter 3) => 3)
(check (reverse-digits-iter 12) => 21)
(check (reverse-digits-iter 42) => 24)
(check (reverse-digits-iter 666) => 666)
(check (reverse-digits-iter 1337) => 7331)
(check (reverse-digits-iter 65510) => 1556)
(check (reverse-digits-iter 1234567) => 7654321)
(check (reverse-digits-iter 8833443388) => 8833443388)
(check (reverse-digits-iter 100000000000) => 1)

(check-report)
(check-reset!)
