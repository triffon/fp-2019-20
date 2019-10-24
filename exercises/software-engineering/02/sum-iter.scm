(define (sum-iter start end)
  (define (iter sum start)
    (if (> start end)
        sum
        (iter (+ sum start)
              (+ start 1))))

  (iter 0 start))

(load "../testing/check.scm")

(check (sum-iter 2 1) => 0)
(check (sum-iter 1 1) => 1)
(check (sum-iter 1 2) => 3)
(check (sum-iter 1 3) => 6)
(check (sum-iter 0 4) => 10)
(check (sum-iter -4 2) => -7)

(check-report)
(check-reset!)
