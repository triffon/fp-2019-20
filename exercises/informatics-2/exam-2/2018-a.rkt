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
       (empty-tree? (right-tree tree)))

(define (grow t x)
  (cond ((empty-tree? t) the-empty-tree)
        ((leaf-tree? t) (make-tree (root-tree t)
                                   (make-leaf x)
                                   (make-leaf x)))
        (else (make-tree (root-tree t)
                         (grow (left-tree t) x)
                         (grow (right-tree t) x)))))

(define (growing-trees)
  (define (iterate t n)
    (stream-cons t
                 (iterate (grow t n)
                          (+ n 1))))

  (iterate (make-leaf 1) 2))

(define (stream-take n s)
  (if (= n 0)
      empty-stream
      (stream-cons (stream-first s)
                   (stream-take (- n 1)
                                (stream-rest s)))))

(define (stream-list s)
  (if (stream-empty? s)
      '()
      (cons (stream-first s)
            (stream-list (stream-rest s)))))

(define first-ten-trees (stream-list (stream-take 10 (growing-trees))))

(map (lambda (tree) (display tree) (newline) (newline)) first-ten-trees)