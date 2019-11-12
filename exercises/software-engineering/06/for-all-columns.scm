

(load "../testing/check.scm")

(define (any? p l)
  (and (not (null? l))
       (or (p (car l))
           (any? p (cdr l)))))

(define (odd-exists? l)
  (any? odd? l))

(check (for-all-columns? odd-exists? '((1))) => #t)
(check (for-all-columns? odd-exists? '((1) (2))) => #t)
(check (for-all-columns? odd-exists? '((1 2 3))) => #f)
(check (for-all-columns? odd-exists? '((1 2 3) (4 5 6))) => #t)
(check (for-all-columns? odd-exists? '((1 2 3) (4 5 6) (7 8 9))) => #t)
(check (for-all-columns? odd-exists? '((1 2 3) (4 42 6) (7 8 9))) => #f)

(check-report)
(check-reset!)
