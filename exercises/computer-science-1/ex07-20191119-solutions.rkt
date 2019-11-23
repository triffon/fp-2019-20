; test
(define empty-tree '())
(define (make-tree root left right) (list root left right))      ; не искаме просто (define make-tree list) - защо?
(define (make-leaf root) (make-tree root empty-tree empty-tree)) ; за удобство
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define (bst-insert val t)
  (cond ((empty-tree? t)
         (make-leaf val))
        ((< val (root-tree t))
         (make-tree (root-tree t)
                    (bst-insert val (left-tree t))
                    (right-tree t)))
        (else
         (make-tree (root-tree t)
                    (left-tree t)
                    (bst insert val (right-tree t))))))


(define (max-tree t)
  (define (helper curr t)
    (if (empty-tree? t)
        curr
        (let ((newMax (max curr
                           (root-tree t))))
          (max (helper newMax (left-tree t))
               (helper newMax (right-tree t))))))
  (helper (root-tree t) t))

(define (filter p? l)
  (cond ((null? l) '())
        ((p? (car l))
         (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (vertices g) (map car g))

(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

(define (all? p? l)
  (not (search
        (lambda (x) (not (p? x)))
        l)))

(define (children u g) (cdr (assv u g)))

(define (edge? u v g) (memv v (children u g)))

(define (is-chinese? g)
  (define (has-many-children u g)
    (> (length (children u g)) 1))
  (define (is-only-child u g)
    (all? (lambda (v)
            (not (has-many-children v g)))
          (filter (lambda (v)
                    (edge? v u g))
                  (vertices g))))
  (define (helper u g)
    ; ако u има повече от един наследник,
    ; то u трябва да е единствен наследник
    (or (not (has-many-children u g))
        (is-only-child u g)))
  (all? (lambda (u)
          (helper u g))
        (vertices g)))

(define g '((1 2 3)
            (2 3 4)
            (3 4)
            (4 5)
            (5)))

;<израз>
; трансформираме в
;(begin
;  (display <нещо>)
;  (display <нещо друго>)
;  <израз>)

(define (same-as-code t)
  ; Инварианта: code е пътят до корена на t
  (define (helper t code)
    (if (empty-tree? t)
        '()
        (let ((left-result
               (helper (left-tree t) (append code '(0))))
              (right-result
               (helper (right-tree t) (append code '(1)))))
          (if (match? (root-tree t) code)
              (append left-result
                      (list (root-tree t))
                      right-result)
              (append left-result
                      right-result))
  (helper t '(1))