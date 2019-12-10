(load "./graph.scm")
(load "./edges.scm")
(load "../04/fold.scm")

(define (invert g)
  (foldl (lambda (inverted edge)
           (add-edge (cdr edge) (car edge) inverted))
         (make-graph (vertices g))
         (edges g)))
