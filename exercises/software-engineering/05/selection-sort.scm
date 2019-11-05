

(load "../testing/check.scm")

(check (selection-sort '()) => '())
(check (selection-sort '(42)) => '(42))
(check (selection-sort '(6 6 6)) => '(6 6 6))
(check (selection-sort '(1 2 3 4 5 6)) => '(1 2 3 4 5 6))
(check (selection-sort '(6 5 4 3 2 1)) => '(1 2 3 4 5 6))
(check (selection-sort '(3 1 4 6 2 5)) => '(1 2 3 4 5 6))
(check (selection-sort '(5 2 5 1 5 2 3)) => '(1 2 2 3 5 5 5))

(check-report)
(check-reset!)
