(load "./binary-tree.scm")



(load "../testing/check.scm")

(check (level 0 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(1))
(check (level 1 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(2 3))
(check (level 2 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(4 5))

(check-report)
(check-reset!)
