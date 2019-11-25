(load "./binary-tree.scm")

(define (level n tree)
  (cond ((empty-tree? tree) empty-tree)
        ((= n 0) (list (root-tree tree)))
        (else (append (level (- n 1) (left-tree tree))
                      (level (- n 1) (right-tree tree))))))

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
