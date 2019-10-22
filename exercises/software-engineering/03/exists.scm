

(load "../testing/check.scm")

(check (exists? (lambda (x) (= x 3)) 1 5) => #t)
(check (exists? (lambda (x) (< x 0)) -3 9) => #t)
(check (exists? (lambda (x) (= 0 (* x 0))) -3 15) => #t)

(check (exists? (lambda (x) (= x 13)) 1 5) => #f)
(check (exists? (lambda (x) (< x 3)) 10 42) => #f)
(check (exists? (lambda (x) (< x 0)) 3 8) => #f)
(check (exists? (lambda (x) (= 0 (* x 0))) 2 1) => #f)

(check-report)
(check-reset!)
