(module stream racket
  (provide make-tree
           make-leaf
           root-tree
           left-tree
           right-tree
           the-empty-tree
           empty-tree?
           tree?
           leaf-tree?)

  (define the-empty-tree '())

  (define (make-tree root left right)
    (cons root
          (cons left right)))

  (define (make-leaf root)
    (make-tree root
               the-empty-tree
               the-empty-tree))

  (define root-tree car)

  (define left-tree cadr)

  (define right-tree cddr)

  (define empty-tree? null?)

  (define tree? pair?)

  (define (leaf-tree? tree)
    (and (tree? tree))
         (empty-tree? (left-tree tree))
         (empty-tree? (right-tree tree))))
