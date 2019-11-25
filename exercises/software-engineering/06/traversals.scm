(load "./binary-tree.scm")

(define (pre-order tree)
  (if (empty-tree? tree)
      empty-tree
      (cons (root-tree tree)
            (append (pre-order (left-tree tree))
                    (pre-order (right-tree tree))))))

(define (in-order tree)
  (if (empty-tree? tree)
      empty-tree
      (append (in-order (left-tree tree))
              (list (root-tree tree))
              (in-order (right-tree tree)))))

(define (post-order tree)
  (if (empty-tree? tree)
      empty-tree
      (append (post-order (left-tree tree))
              (post-order (right-tree tree))
              (list (root-tree tree)))))

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
