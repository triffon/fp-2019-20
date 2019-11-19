(load "./binary-tree.scm")



(load "../testing/check.scm")

(define tree
  (make-tree 1
             (make-tree 2
                        (leaf 4)
                        (leaf 5))
             (leaf 3)))

(check (pre-order tree) => '(1 2 4 5 3))
(check (in-order tree) => '(4 2 5 1 3))
(check (post-order tree) => '(4 5 2 3 1))

(check-report)
(check-reset!)
