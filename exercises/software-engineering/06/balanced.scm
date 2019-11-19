(load "./binary-tree.scm")



(load "../testing/check.scm")

(define balanced-tree
  (make-tree 1
             (make-tree 2
                        empty-tree
                        (leaf 5))
             (leaf 42)))

(define !balanced-tree
  (make-tree 1
             (make-tree 2
                        (make-tree 42
                                   (leaf 1337)
                                   empty-tree)
                        (leaf 5))
             (leaf 3)))

(check (balanced? empty-tree) => #t)
(check (balanced? (leaf 42)) => #t)
(check (balanced? balanced-tree) => #t)
(check (balanced? !balanced-tree) => #f)

(check-report)
(check-reset!)
