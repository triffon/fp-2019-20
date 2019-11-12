(define g '((1 2 3)
 (2 3 6)
 (3 4 6)
 (4 1 5)
 (5 3)
 (6 5 7) (7)))

(define g2 '((1 2 3) (2 1) (3 1)))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (keys al) (map car al))

(define (search p l)
  (and (not (null? l))
       (or (p (car l)) (search p (cdr l)))))

(define (all? p? l)
  (not (search (lambda (x) (not (p? x))) l)))

(define vertices keys)

(define (children u g) (cdr (assv u g)))

(define (edge? u v g) (memv v (children u g)))

(define (map-children v f g) (map f (children v g)))

(define (search-child v f g) (search f (children v g)))

(define (childless g)
  (filter (lambda (v) (null? (children v g))) (vertices g)))

(define (parents v g)
  (filter (lambda (u) (edge? u v g)) (vertices g)))

(define (symmetric? g)
  (all? (lambda (u)
          (all? (lambda (v) (edge? v u g)) (children u g)))
        (vertices g)))
