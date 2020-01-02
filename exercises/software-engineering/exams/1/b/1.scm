(define (sum-digits-divisors n)
  (define (last-digit n)
    (remainder n 10))

  (define (without-last-digit n)
    (quotient n 10))

  (define (divides? divisor dividend)
    (= (remainder dividend divisor) 0))

  (define (iter sum current-n)
    (let ((digit (last-digit current-n)))
      (cond ((= current-n 0) sum)
            ((and (not (= digit 0))
                  (divides? digit n))
             (iter (+ sum digit) (without-last-digit current-n)))
            (else (iter sum (without-last-digit current-n))))))

  (iter 0 n))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (flatmap f l)
  (apply append (map f l)))

(define (filter p l)
  (cond ((null? l) '())
        ((p (car l)) (cons (car l)
                     (filter p (cdr l))))
        (else (filter p (cdr l)))))

(define (identity x) x)

(define (same-sum a b)
  (length (filter identity
                  (flatmap (lambda (n)
                             (map (lambda (m)
                                    (= (sum-digits-divisors m)
                                       (sum-digits-divisors n)))
                                  (enumerate-interval a (- n 1))))
                           (enumerate-interval (+ a 1) b)))))

(load "../../../testing/check.scm")

(check (sum-digits-divisors 0) => 0)
(check (sum-digits-divisors 1) => 1)
(check (sum-digits-divisors 6) => 6)
(check (sum-digits-divisors 10) => 1)
(check (sum-digits-divisors 42) => 2)
(check (sum-digits-divisors 29) => 0)
(check (sum-digits-divisors 123) => 4)
(check (sum-digits-divisors 1337) => 8)
(check (sum-digits-divisors 222) => 6)

(check (same-sum 0 0) => 0)
(check (same-sum 2 2) => 0)
(check (same-sum 13 13) => 0)
(check (same-sum 13 19) => 15)
(check (same-sum 20 22) => 0)
(check (same-sum 28 35) => 2)

(check-report)
(check-reset!)
