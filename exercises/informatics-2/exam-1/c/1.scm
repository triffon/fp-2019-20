(require rackunit rackunit/text-ui)

(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (divides? x n)
  (and (not (= x 0))
       (= 0 (remainder n x))))

(define (get-divisors n)
  (filter (lambda (x) (divides? x n))
          (enumerate-interval 1 n)))

(define (sum l) (foldl + 0 l))

(define (intersection l1 l2)
  (filter (lambda (x) (member x l2)) l1))

(define (sum-common-divisors a b)
  (sum (intersection (get-divisors a)
                     (get-divisors b))))

(define sum-common-divisors-tests
  (test-suite
    "Tests for sum-common-divisors"

    (check-equal? (sum-common-divisors 2 2) 3)
    (check-equal? (sum-common-divisors 12 6) 12)))

(run-tests sum-common-divisors-tests)



(define (maximum l)
  (foldl max (car l) (cdr l)))

(define (max-map f l)
  (maximum (map f l)))

; ако няма l = r, сумата служебно е нула
(define (greatest-sum a b)
  (let ((interval (enumerate-interval a b)))
       (max-map (lambda (l)
                  (max-map (lambda (r)
                             (if (= l r)
                                 0
                                 (sum-common-divisors l r)))
                           interval))
                interval)))

(define greatest-sum-tests
  (test-suite
    "Tests for greatest-sum"

    (check-equal? (greatest-sum 42 42) 0)
    (check-equal? (greatest-sum 24 32) 15)
    (check-equal? (greatest-sum 21 34) 15)))

(run-tests greatest-sum-tests)


