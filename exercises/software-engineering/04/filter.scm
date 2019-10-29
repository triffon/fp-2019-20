

(load "../testing/check.scm")

(check (filter even? '()) => '())
(check (filter even? '(42)) => '(42))
(check (filter odd? '(42)) => '())
(check (filter (lambda (x) (> x 0)) '(1 2 3 4)) => '(1 2 3 4))
(check (filter (lambda (x) (< x 0)) '(1 2 3 4)) => '())
(check (filter (lambda (x) (< x 0)) '(1 2 -42 3 4)) => '(-42))
(check (filter even? '(8 4 92 82 8 13)) => '(8 4 92 82 8))
(check (filter odd? '(8 4 92 82 8 13)) => '(13))

(check-report)
(check-reset!)
