(require rackunit rackunit/text-ui)

(define (number->digits n)
  (if (< n 10)
      (list n)
      (cons (remainder n 10)
            (number->digits (quotient n 10)))))

(define (divides? x n)
  (and (not (= x 0))
       (= 0 (remainder n x))))

(define (sum l) (foldl + 0 l))

(define (sum-digit-divisors n)
  (sum (filter (lambda (x) (divides? x n))
               (number->digits n))))

(define sum-digit-divisors-tests
  (test-suite
    "Tests for sum-digit-divisors"

    (check-equal? (sum-digit-divisors 46) 0)
    (check-equal? (sum-digit-divisors 52) 2)
    (check-equal? (sum-digit-divisors 222) 6)
    (check-equal? (sum-digit-divisors 123) 4)
    (check-equal? (sum-digit-divisors 3210) 6)
    (check-equal? (sum-digit-divisors 76398743) 0)))

(run-tests sum-digit-divisors-tests)





(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (same-digit-divisors-sum? m n)
  (= (sum-digit-divisors m)
     (sum-digit-divisors n)))

(define (sum l) (foldl + 0 l))

(define (count p l)
  (length (filter p l)))

(define (same-sum a b)
  (let ((interval (enumerate-interval a b)))
       (sum (map (lambda (l)
                   (count (lambda (r)
                            (and (< l r) (same-digit-divisors-sum? l r)))
                          interval))
                 interval))))

(define same-sum-tests
  (test-suite
    "Tests for same-sum"

    (check-equal? (same-sum 42 42) 0)
    (check-equal? (same-sum 28 35) 2)
    (check-equal? (same-sum 1 30) 57)))

(run-tests same-sum-tests)


