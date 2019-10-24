

(load "../testing/check.scm")

(check (count even? 1 5) => 2)
(check (count even? 0 10) => 6)
(check (count odd? 1 5) => 3)
(check (count odd? 0 10) => 5)

(check-report)
(check-reset!)
