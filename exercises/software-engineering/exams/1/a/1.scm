(define (product-digits n)
  (define (last-digit n)
    (remainder n 10))

  (define (without-last-digit n)
    (quotient n 10))

  (if (< n 10)
      n
      (* (last-digit n)
         (product-digits (without-last-digit n)))))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (flatmap f l)
  (apply append (map f l)))

(define (largest-diff a b)
  (define (product-diff n)
    (- n (product-digits n)))

  (define interval (enumerate-interval a b))

  (apply max
         (flatmap (lambda (m)
                    (map (lambda (n)
                           (- (product-diff m)
                              (product-diff n)))
                         interval))
                  interval)))

(load "../../../testing/check.scm")

(check (product-digits 0) => 0)
(check (product-digits 1) => 1)
(check (product-digits 6) => 6)
(check (product-digits 10) => 0)
(check (product-digits 42) => 8)
(check (product-digits 123) => 6)
(check (product-digits 1337) => 63)
(check (product-digits 13037) => 0)

(check (largest-diff 0 0) => 0)
(check (largest-diff 2 2) => 0)
(check (largest-diff 13 13) => 0)
(check (largest-diff 13 19) => 0)
(check (largest-diff 13 21) => 10)
(check (largest-diff 20 22) => 2)
(check (largest-diff 28 35) => 19)

(check-report)
(check-reset!)
