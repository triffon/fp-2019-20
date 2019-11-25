(load "./binary-tree.scm")

(define (binary-heap? tree)
  (or (empty-tree? tree)
      (and (or (empty-tree? (left-tree tree))
               (< (root-tree tree)
                  (root-tree (left-tree tree))))
           (or (empty-tree? (right-tree tree))
               (< (root-tree tree)
                  (root-tree (right-tree tree))))
           (binary-heap? (left-tree tree))
           (binary-heap? (right-tree tree)))))

(load "../testing/check.scm")

(define binary-heap
  (make-tree 1
             (make-tree 2
                        (leaf 4)
                        (leaf 5))
             (leaf 42)))

(define !binary-heap
  (make-tree 1
             (make-tree 2
                        (leaf 0)
                        (leaf 5))
             (leaf 3)))

(check (binary-heap? empty-tree) => #t)
(check (binary-heap? (leaf 42)) => #t)
(check (binary-heap? binary-heap) => #t)
(check (binary-heap? !binary-heap) => #f)

(check-report)
(check-reset!)
