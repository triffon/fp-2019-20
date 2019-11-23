

(load "../testing/check.scm")

(check (reverse-columns '((1))) => '((1)))
(check (reverse-columns '((1) (2))) => '((1) (2)))
(check (reverse-columns '((1 2 3))) => '((3 2 1)))
(check (reverse-columns '((1 2 3) (4 5 6))) => '((3 2 1) (6 5 4)))
(check (reverse-columns '((1 2 3) (4 5 6) (7 8 9)))
       => '((3 2 1) (6 5 4) (9 8 7)))

(check-report)
(check-reset!)
