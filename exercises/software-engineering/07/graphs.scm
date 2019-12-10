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

(define (flatmap f l)
  (apply append (map f l)))

(define (edges g)
  (flatmap (lambda (v)
             (map-children v (lambda (child)
                               (cons v child)) g))
           (vertices g)))

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (symmetric? g)
  (every? (lambda (edge)
            (edge? (cdr edge) (car edge) g))
          (edges g)))

(define (foldl operation null-value l)
  (if (null? l)
      null-value
      (foldl operation
             (operation null-value (car l))
             (cdr l))))

(define (invert g)
  (foldl (lambda (inverted edge)
           (add-edge (cdr edge) (car edge) inverted))
         (make-graph (vertices g))
         (edges g)))

(define (path? u v g)
  (define (dfs visited)
    (let ((current (car visited)))
      (or (equal? current v)
          (search-child current
                        (lambda (child)
                          (and (not (member child visited))
                               (dfs (cons child visited))))
                        g))))

  (dfs (list u)))

(define g (add-edge 'c 'd
                    (add-edge 'c 'a
                              (add-edge 'b 'c
                                        (add-edge 'a 'c
                                                  (add-edge 'a 'b
                                                            (make-graph '(a b c d))))))))
