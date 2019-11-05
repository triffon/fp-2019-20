

(load "../testing/check.scm")

(check (endomorphism? '() + (lambda (x) (remainder x 3))) => #t)
(check (endomorphism? '(0 1 4 6) + (lambda (x) x)) => #t)
(check (endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3))) => #t)
(check (endomorphism? '(0 1 4 5 6) + (lambda (x) (remainder x 3))) => #f)
(check (endomorphism? '(0 1 4 6) expt (lambda (x) (+ x 1))) => #f)

(check-report)
(check-reset!)
