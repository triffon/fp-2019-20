(load "./graph.scm")

(define (degree v g)
  (define (degree- v g)
    (length (children v g)))

  (define (degree+ v g)
    (length (filter (lambda (u)
                      (edge? u v g))
                    (vertices g))))

  (+ (degree- v g)
     (degree+ v g)))
