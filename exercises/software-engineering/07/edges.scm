(load "./graph.scm")

(define (flatmap f l)
  (apply append (map f l)))

(define (edges g)
  (flatmap (lambda (u)
             (map-children u
                           (lambda (v) (cons u v))
                           g))
           (vertices g)))
