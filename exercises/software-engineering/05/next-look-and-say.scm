

(load "../testing/check.scm")

(check (next-look-and-say '()) => '())
(check (next-look-and-say '(1)) => '(1 1))
(check (next-look-and-say '(1 1 2 3 3)) => '(2 1 1 2 2 3))
(check (next-look-and-say '(1 1 2 2 3 3 3 3)) => '(2 1 2 2 4 3))

(check-report)
(check-reset!)
