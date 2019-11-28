(require rackunit rackunit/text-ui)

(define (product-digits n)
  (if (< n 10)
      n
      (* (remainder n 10)
         (product-digits (quotient n 10)))))

(define product-digits-tests
  (test-suite
    "Tests for product-digits"

    (check-equal? (product-digits 0) 0)
    (check-equal? (product-digits 2) 2)
    (check-equal? (product-digits 123) 6)
    (check-equal? (product-digits 321) 6)
    (check-equal? (product-digits 3210) 0)
    (check-equal? (product-digits 76398743) 762048)))

(run-tests product-digits-tests)



(define ({x} x)
  (- x
     (product-digits x)))

(define (diff m n)
  (- ({x} m)
     ({x} n)))

(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (max-map f l)
  (apply max (map f l)))

(define (largest-diff a b)
  (let ((interval (enumerate-interval a b)))
       (max-map (lambda (m)
                  (max-map (lambda (n) (diff m n)) interval))
                interval)))

(define largest-diff-tests
  (test-suite
    "Tests for largest-diff"

    (check-equal? (largest-diff 1 2) 0)
    (check-equal? (largest-diff 9 10) 10)
    (check-equal? (largest-diff 13 26) 10)
    (check-equal? (largest-diff 130 262) 148)
    (check-equal? (largest-diff 28 35) 19)))

(run-tests largest-diff-tests)
