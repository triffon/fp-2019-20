(load "./association-list.scm")

(define vertices keys)
(define (children v g)
  (cdr (assoc v g)))
(define (edge? u v g)
  (member v (children u)))

(define (map-children v f g)
  (map f (children v g)))

(define (any? p l)
  (and (not (null? l))
       (or (p (car l))
           (any? p (cdr l)))))

(define (search-child v p g)
  (any? p (children v g)))
