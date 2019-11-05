

(load "../testing/check.scm")

(check (meet-twice? (lambda (x) x) (lambda (x) x) 0 5) => #t)
(check (meet-twice? (lambda (x) x) sqrt 0 5) => #t)
(check (meet-twice? (lambda (x) x) (lambda (x) x) 42 42) => #f)
(check (meet-twice? (lambda (x) x) (lambda (x) (- x)) -3 1) => #f)

(check-report)
(check-reset!)
