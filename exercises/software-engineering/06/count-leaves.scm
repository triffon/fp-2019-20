(load "./binary-tree.scm")



(load "../testing/check.scm")

(check (count-leaves '()) => 0)
(check (count-leaves '(1 () ())) => 1)
(check (count-leaves '(1 (2 (4 () ()) (5 () ())) (3 () ()))) => 3)  

(check-report)
(check-reset!)
