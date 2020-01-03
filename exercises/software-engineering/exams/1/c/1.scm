(define (sum-common-divisors a b)
  (define (last-digit n)
    (remainder n 10))

  (define (without-last-digit n)
    (quotient n 10))

  (define (divides? divisor dividend)
    (= (remainder dividend divisor) 0))

  (define (iter sum a b divisor)
    (cond ((> divisor a) sum)
          ((and (divides? divisor a)
                (divides? divisor b))
           (iter (+ sum divisor) a b (+ divisor 1)))
          (else (iter sum a b (+ divisor 1)))))

  (if (< b a)
      (iter 0 b a 1)
      (iter 0 a b 1)))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (flatmap f l)
  (apply append (map f l)))

(define (greatest-sum a b)
  (apply max (flatmap (lambda (n)
                        (map (lambda (m)
                               (sum-common-divisors m n))
                             (enumerate-interval a (- n 1))))
                      (enumerate-interval (+ a 1) b))))

(load "../../../testing/check.scm")

(check (sum-common-divisors 1 1) => 1)
(check (sum-common-divisors 1 2) => 1)
(check (sum-common-divisors 2 1) => 1)
(check (sum-common-divisors 3 3) => 4)
(check (sum-common-divisors 10 15) => 6)
(check (sum-common-divisors 17 5) => 1)
(check (sum-common-divisors 42 21) => 32)

(check (greatest-sum 13 14) => 1)
(check (greatest-sum 20 22) => 3)
(check (greatest-sum 28 35) => 8)
(check (greatest-sum 21 34) => 15)
(check (greatest-sum 21 42) => 32)

(check-report)
(check-reset!)
