

(load "../testing/check.scm")

(check (for-all? (lambda (x) (> x 0)) 2 98) => #t)
(check (for-all? (lambda (x) (< x 0)) -10 -1) => #t)
(check (for-all? (lambda (x) (= 0 (* x 0))) -3 15) => #t)
(check (for-all? (lambda (x) (= 0 (* x 1))) 2 1) => #t)

(check (for-all? (lambda (x) (= x 3)) 1 5) => #f)
(check (for-all? (lambda (x) (= x 13)) 1 5) => #f)
(check (for-all? (lambda (x) (< x 3)) -5 42) => #f)

(check-report)
(check-reset!)
