

(load "../testing/check.scm")

(check (count-columns '((1))) => 1)
(check (count-columns '((1 2))) => 2)
(check (count-columns '((1) (2))) => 0)
(check (count-columns '((1 3 5 7) (2 5 3 4))) => 2)
(check (count-columns '((1 3 5 7) (2 5 3 7))) => 3)
(check (count-columns '((1 4 3) (4 5 6) (7 4 9))) => 1)
(check (count-columns '((1 4 3) (4 5 6) (7 3 9))) => 0)

(check-report)
(check-reset!)
