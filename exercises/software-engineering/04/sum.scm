(define (sum l)
  (if (null? l)
      0
      (+ (car l)
         (sum (cdr l)))))

(load "../testing/check.scm")

(check (sum '()) => 0)
(check (sum '(2)) => 2)
(check (sum '(1 2)) => 3)
(check (sum '(3 4 1)) => 8)
(check (sum '(5 3 5 5)) => 18)
(check (sum '(8 4 92 82 8)) => 194)
(check (sum '(8 4 82 12 31 133)) => 270)
(check (sum '(1 2 3 4 5 6 7 8 9 10)) => 55)

(check-report)
(check-reset!)
