

(load "../testing/check.scm")

(check (main-diagonal '((1))) => '(1))
(check (main-diagonal '((1 2) (3 4))) => '(1 4))
(check (main-diagonal '((1 2 3) (4 5 6) (7 8 9))) => '(1 5 9))

(check-report)
(check-reset!)
