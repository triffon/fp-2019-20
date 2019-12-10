(load "./graph.scm")
(load "./edges.scm")

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (symmetric? g)
  (every? (lambda (edge)
            (edge? (cdr edge) (car edge) g))
          (edges g)))
