(define (tree? t)
  (or (null? t)
      (and (list? t) (= (length t) 3) (tree? (cadr t)) (tree? (caddr t)))))

(define (leaf x) (make-tree x empty-tree empty-tree))


(define empty-tree '())

(define (make-tree root left right) (list root left right))
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define t (make-tree 1 (leaf 2) (make-tree 3 (leaf 4) (leaf 5))))

(define (depth t)
  (if (empty-tree? t) 0
      (+ 1 (max (depth (left-tree t)) (depth (right-tree t))))))

(define (memv-tree x t)
  (cond ((empty-tree? t) #f)
        ((eqv? x (root-tree t)) t)
        (else (or (memv-tree x (left-tree t))
                  (memv-tree x (right-tree t))))))

(define (cons#f h t) (and t (cons h t)))

(define (path-tree x t)
  (cond ((empty-tree? t) #f)
        ((eqv? x (root-tree t)) (list (root-tree t)))
        (else (cons#f (root-tree t)
                      (or (path-tree x (left-tree t))
                          (path-tree x (right-tree t)))))))
(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))


(define (search p l)
  (and (not (null? l))
       (or (p (car l)) (search p (cdr l)))))

(define (exists? p? l)
  (not (null? (filter p? l))))