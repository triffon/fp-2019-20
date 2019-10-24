(define (factorial-iter n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* product counter)
              (+ counter 1))))

  (iter 1 1))

(load "../testing/check.scm")

(check (factorial-iter 0) => 1)
(check (factorial-iter 1) => 1)
(check (factorial-iter 2) => 2)
(check (factorial-iter 3) => 6)
(check (factorial-iter 4) => 24)
(check (factorial-iter 5) => 120)
(check (factorial-iter 6) => 720)
(check (factorial-iter 7) => 5040)

(check-report)
(check-reset!)
