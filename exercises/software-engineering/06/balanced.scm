(load "./binary-tree.scm")

(define (height tree)
  (if (empty-tree? tree)
      0
      (+ 1
         (max (height (left-tree tree))
              (height (right-tree tree))))))

(define (balanced? tree)
  (or (empty-tree? tree)
      (and (< (abs (- (height (left-tree tree))
                      (height (right-tree tree))))
              2)
           (balanced? (left-tree tree))
           (balanced? (right-tree tree)))))

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
