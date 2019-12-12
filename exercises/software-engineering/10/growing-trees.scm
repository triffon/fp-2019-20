(load "./binary-tree.scm")
(load "./stream.scm")

(define (grow t x)
  (cond ((empty-tree? t) empty-tree)
        ((leaf? t) (make-tree (root-tree t)
                              (leaf x)
                              (leaf x)))
        (else (make-tree (root-tree t)
                         (grow (left-tree t) x)
                         (grow (right-tree t) x)))))

(define (growing-trees)
  (define (generate t level)
    (cons-stream t
                 (generate (grow t level)
                           (+ level 1))))

  (generate (leaf 0) 1))
