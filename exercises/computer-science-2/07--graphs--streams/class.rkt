#lang racket
(define empty-tree '())
(define (make-tree root left right)
  (list root left right))

(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)

(define (empty-tree? x)
  (eq? x empty-tree))
(define (leaf? x)
  (and (empty-tree? (left-tree x))
       (empty-tree? (right-tree x))))
; tree?
(define (tree? x)
  (if (empty-tree? x)
      #t
      (and (list? x)
           (= (length x) 3)
           (tree? (left-tree x))
           (tree? (right-tree x)))))
(define t1 '(5 (1 (6 () ())
                  (7 () ()))
               (2 () ())))
(define t2 (make-tree 5
                      (make-tree 6 '() '())
                      (make-tree 7
                                 (make-tree 1
                                            (make-tree 4'() '())
                                            '())
                                 (make-tree 8 '() '()))))

(define t3 (make-tree 5
                      (make-tree 6 '() '())
                      (make-tree 7
                                 (make-tree 9
                                            (make-tree 9'() '())
                                            '())
                                 (make-tree 8 '() '()))))

; collect-pre-order; collect-in-order; collect-post-order

(define (collect-in-order t)
  (if (empty-tree? t)
      '()
      (append (collect-in-order (left-tree t))
              (list (root-tree t))
              (collect-in-order (right-tree t)))))
 
(define (collect-pre-order t)
  (if (empty-tree? t)
      '()
      (append (list (root-tree t))
              (collect-pre-order (left-tree t))
              (collect-pre-order (right-tree t)))))

(define (collect-post-order t)
  (if (empty-tree? t)
      '()
      (append (collect-post-order (left-tree t))
              (collect-in-order (right-tree t))
              (list (root-tree t)))))


;height
(define (tree-height t)
  (if (or (empty-tree? t)
           (leaf? t))
      0
      (+ 1 (max (tree-height (left-tree t))
           (tree-height (right-tree t))))))
; level n
(define (level t n)
  (cond ((empty-tree? t) '())
        ((= n 0) (list (root-tree t)))
        (else (append (level (left-tree t) (- n 1))
                      (level (right-tree t) (- n 1))))))
      
; count-leaves
(define (count-leaves t)
  (cond ((empty-tree? t) 0)
        ((leaf? t) 1)
        (else (+ (count-leaves (left-tree t))
                 (count-leaves (right-tree t))))))
; remove-leaves
(define (remove-leaves t)
  (cond ((empty-tree? t) t)
        ((leaf? t) '())
        (else (make-tree (root-tree t)
                         (remove-leaves (left-tree t))
                         (remove-leaves (right-tree t))))))
; map-tree
(define (map-tree f t)
  (cond ((empty-tree? t) t)
        (else (make-tree (f (root-tree t))
                         (map-tree f (left-tree t))
                         (map-tree f (right-tree t))))))

;;? binary-heap?
(define (binary-heap? t)
  (if (empty-tree? t)
      #t
      ;(and (bh-helper (root-tree t) (left-tree t))
      ;     (bh-helper (root-tree t) (right-tree t)))
      (bh-helper (root-tree t) t)))

(define (bh-helper x t)
  (if (empty-tree? t)
      #t
      (and (<= x (root-tree t))
           (bh-helper (root-tree t) (left-tree t))
           (bh-helper (root-tree t) (right-tree t)))))

; fold-tree

; invert

; balanced

; bst?
(define (bst? t)
  (and (tree? t)
       (or (empty-tree? t)
           (let ((left-root (if (empty-tree? (left-tree t))
                                -inf.0
                                (root-tree (left-tree t))))
                 (right-root (if (empty-tree? (right-tree t))
                                 +inf.0
                                 (root-tree (right-tree t)))))
             (and (<= left-root (root-tree t))
                  (> right-root (root-tree t))
                  (bst? (left-tree t))
                  (bst? (right-tree t)))))))

; insert-bst
(define (insert-bst x t)
  (cond ((empty-tree? t) (make-tree x '() '()))
        
        ((<= x (root-tree t)) (make-tree (root-tree t)
                                         (insert-bst x (left-tree t))
                                         (right-tree t)))
        (else (make-tree (root-tree t)
                         (left-tree t)
                         (insert-bst x (right-tree t))))))
; max-path

;;;;; Associative lists
; make-alist f keys

(define (make-alist f keys)
  (map (lambda (k)
         (cons k (f k)))
       keys))

(define (assoc* k kvs)
  (define (guarded-car l)
    (and (not (null? l))
         (car l)))
  (guarded-car (filter (lambda (kv)
            (equal? k (car kv)))
          kvs)))


(define (assq k kvs)
  (define (guarded-car l)
    (and (not (null? l))
         (car l)))
  (guarded-car (filter (lambda (kv)
            (eq? k (car kv)))
          kvs)))

(define (assv k kvs)
  (define (guarded-car l)
    (and (not (null? l))
         (car l)))
  (guarded-car (filter (lambda (kv)
            (eqv? k (car kv)))
          kvs)))
; keys
(define (keys kvs)
  (map car
       kvs))
; values
(define (values kvs)
  (map cdr
       kvs))
; assoc, assq, assv
; del-assoc
(define (del-assoc k kvs)
  (filter (lambda (kv)
            (not (equal? k (car kv))))
          kvs))
; add-assoc

; search

