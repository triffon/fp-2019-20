(define (sum start end)
  (if (> start end)
      0
      (+ start
         (sum (+ start 1) end))))

(load "../testing/check.scm")

(check (sum 2 1) => 0)
(check (sum 1 1) => 1)
(check (sum 1 2) => 3)
(check (sum 1 3) => 6)
(check (sum 0 4) => 10)
(check (sum -4 2) => -7)

(check-report)
(check-reset!)
