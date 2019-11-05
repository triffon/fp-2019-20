(load "./filter.scm")
(load "../03/compose.scm")

(define (reject p l)
  (filter (compose not p) l))

(load "../testing/check.scm")

(check (reject even? '()) => '())
(check (reject even? '(42)) => '())
(check (reject odd? '(42)) => '(42))
(check (reject (lambda (x) (> x 0)) '(1 2 3 4)) => '())
(check (reject (lambda (x) (< x 0)) '(1 2 3 4)) => '(1 2 3 4))
(check (reject (lambda (x) (< x 0)) '(1 2 -42 3 4)) => '(1 2 3 4))
(check (reject even? '(8 4 92 82 8 13)) => '(13))
(check (reject odd? '(8 4 92 82 8 13)) => '(8 4 92 82 8))

(check-report)
(check-reset!)
