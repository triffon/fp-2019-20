(define (even? n)
  (= (remainder n 2) 0))

(define (odd? n)
  (not (even? n)))

(load "../testing/check.scm")

(check (even? 0) => #t)
(check (even? 2) => #t)
(check (even? 1) => #f)
(check (even? 42) => #t)
(check (even? 123) => #f)

(check (odd? 0) => #f)
(check (odd? 2) => #f)
(check (odd? 1) => #t)
(check (odd? 42) => #f)
(check (odd? 123) => #t)

(check-report)
(check-reset!)
