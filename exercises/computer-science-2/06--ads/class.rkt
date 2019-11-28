#lang racket
;? cartesian-product

;;;;; Matrices
; from-rows

 (define (from-rows l)
   l)

 (define (first-column m)
   (map car m))
 (define (delete-first-column m)
   (map cdr m))

 (define (from-rows* l)
   (if (null? (car l))
       '()
       (cons (first-column l)
             (from-rows* (delete-first-column l)))))

(define (from-rows** . l)
   (if (null? (car l))
       '()
       (cons (first-column l)
             (apply from-rows** (delete-first-column l)))))

 (define m1 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
; get-row
(define (get-row n m)
  (list-ref m n))
; get-column
 (define (get-column n m)
   (cond ((null? (car m)) '())
         ((= n 0) (first-column m))
         (else (get-column (- n 1) (delete-first-column m)))))
 (define (get-column2 n m)
   (map (lambda (x)
          (list-ref x n))
        m))
; delete-row
; delete-column

; transpose
(define transpose from-rows*)

(define delete-first-row cdr)
(define (empty? m) (null? (car m)))
(define first-row car)
; main-diagonal
(define (above-diag m)
  (if (empty? m)
      '()
      (cons (first-row m)
            (above-diag (delete-first-column (delete-first-row m))))))
(define (below-diag m)
  (if (empty? m)
      '()
      (cons (first-column m)
            (below-diag (delete-first-column (delete-first-row m))))))

(define (main-diagonal m)
  (map car (above-diag m1)))

; map-matrix
(define (map-matrix f m)
  (map (lambda (row)
         (map (lambda (x)
                (f x))
              row))
       m))
; fold-matrix

;;;;; Trees
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
              

; height
; level n
; count-leaves
; remove-leaves
; map-tree

; fold-tree

; invert

; balanced

; bst?
; insert-bst

; max-path
;;;;; Associative lists
; index-array
; histogram
; group-by
;? unique
