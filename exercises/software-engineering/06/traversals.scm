(load "./binary-tree.scm")



(load "../testing/check.scm")

(check (pre-order '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(1 2 4 5 3))
(check (in-order '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(4 2 5 1 3))
(check (post-order '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => '(4 5 2 3 1))

(check-report)
(check-reset!)
