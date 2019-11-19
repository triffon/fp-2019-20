(load "./binary-tree.scm")



(load "../testing/check.scm")

(define tree
  (make-tree 1
             (make-tree 2
                        (leaf 4)
                        (leaf 5))
             (leaf 3)))

(check (level 0 (leaf 42)) => '(42))
(check (level 0 tree) => '(1))
(check (level 1 tree) => '(2 3))
(check (level 2 tree) => '(4 5))

(check-report)
(check-reset!)
