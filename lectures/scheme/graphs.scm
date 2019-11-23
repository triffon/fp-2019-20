(define g '((1 2 3)
 (2 3)
 (3 4 5)
 (4)
 (5 2 4 6)
 (6 2)))

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

(define (map-vertices f g) (map f (vertices g)))

(define (filter-vertices f g) (filter p? (vertices g)))

(define (search-vertex f g) (search f (vertices g)))

(define (childless g)
  (filter-vertices (lambda (v) (null? (children v g))) g))

(define (parents v g)
  (filter-vertices (lambda (u) (edge? u v g)) g))

(define (symmetric? g)
  (all? (lambda (u)
          (all? (lambda (v) (edge? v u g)) (children u g)))
        (vertices g)))

(define (divides d n) (and (= (remainder n d) 0) d))

(define (cons#f h t) (and t (cons h t)))

;; работи само за ациклични графи
;; или за циклични графи, в които не се стига до цикъл при обхожданетоя
(define (dfs-path u v g)
  (if (eqv? u v) (list u)
      (search-child u (lambda (w) (cons#f u (dfs-path w v g))) g)))

(define (dfs-path u v g)
  ; може ли path да се продължи до v?
  (define (dfs-search path)
    (let ((current (car path)))
      (cond ((eqv? current v) (reverse path))
            ((memv current (cdr path)) #f)
            (else (search-child current (lambda (w) (dfs-search (cons w path))) g)))))
  (dfs-search (list u)))

(define (bfs-path u v g)

  (define (extend path)
    (map-children (car path) (lambda (w) (cons w path)) g))

  (define (remains-acyclic? path)
    (not (memv (car path) (cdr path))))

  (define (extend-acyclic path)
    (filter remains-acyclic? (extend path)))

  (define (target-path path) (and (eqv? (car path) v) path))

  (define (bfs-level level)
    (display level)
    (newline)
    (or (search target-path level)
        (bfs-level (apply append (map extend-acyclic level)))))

  (bfs-level (list (list u))))
