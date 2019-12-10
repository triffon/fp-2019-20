(require rackunit rackunit/text-ui "tree.scm")

(define (pre-order tree)
  (if (empty-tree? tree)
      '()
      (append (pre-order (left-tree tree))
              (cons (root-tree tree)
                    (pre-order (right-tree tree))))))

(define tree
  (make-tree 5
             (make-tree 13
                        (make-leaf 4)
                        (make-leaf 9))
             (make-tree 7
                        (make-leaf 2)
                        (make-tree 15
                                   (make-leaf 1)
                                   (make-leaf 5)))))

(define small-tree (left-tree tree))

(define another-tree (right-tree tree))

(define pre-order-tests
  (test-suite
    "Tests for pre-order"

    (check-equal? (pre-order the-empty-tree) '())
    (check-equal? (pre-order (make-leaf 4)) '(4))
    (check-equal? (pre-order small-tree) '(4 13 9))
    (check-equal? (pre-order another-tree) '(2 7 1 15 5))
    (check-equal? (pre-order tree) '(4 13 9 5 2 7 1 15 5))))

(run-tests pre-order-tests)
