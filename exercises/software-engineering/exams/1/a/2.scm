(define (sum l)
  (apply + l))

(define (foldl combiner null-value l)
  (if (null? l)
      null-value
      (foldl combiner (combiner null-value (car l)) (cdr l))))

(define (foldl1 combiner l)
  (foldl combiner (car l) l))

(define (max-by f l)
  (define (max-by-f x y)
    (if (> (f y) (f x)) y x))

  (foldl1 max-by-f l))

(define (max-metric ml ll)
  (define (metric-sum m)
    (sum (map m ll)))

  (max-by metric-sum ml))

(load "../../../testing/check.scm")

(define (sum l) (apply + l))
(define (prod l) (apply * l))

(check (max-metric (list sum) '()) => sum)
(check (max-metric (list sum) '((0 1 2) (3 4 5) (1337 0))) => sum)
(check (max-metric (list sum prod) '((0 1 2) (3 4 5) (1337 0))) => sum)
(check (max-metric (list car sum prod) '((1000 -1000) (29 1) (42))) => car)
(check (max-metric (list car sum prod) '((1000 1000) (29 1) (42))) => prod)

(check-report)
(check-reset!)
