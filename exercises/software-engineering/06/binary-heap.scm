(load "./binary-tree.scm")



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
