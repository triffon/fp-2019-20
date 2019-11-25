(load "./binary-tree.scm")

(define (count-leaves tree)
  (cond ((empty-tree? tree) 0)
        ((leaf? tree) 1)
        (else (+ (count-leaves (right-tree tree))
                 (count-leaves (left-tree tree))))))

(load "../testing/check.scm")

(define tree
  (make-tree 1
             (make-tree 2
                        (leaf 4)
                        (leaf 5))
             (leaf 3)))

(check (count-leaves empty-tree) => 0)
(check (count-leaves (leaf 1)) => 1)
(check (count-leaves tree) => 3)

(check-report)
(check-reset!)
