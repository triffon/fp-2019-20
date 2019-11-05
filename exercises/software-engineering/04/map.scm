(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

(load "../testing/check.scm")

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(check (map square '()) => '())
(check (map identity '(42)) => '(42))
(check (map 1+ '(41)) => '(42))
(check (map 1+ '(1 2 3 4)) => '(2 3 4 5))
(check (map square '(1 2 3 4 5)) => '(1 4 9 16 25))
(check (map identity '(8 4 92 82 8 13)) => '(8 4 92 82 8 13))
(check (map 1+ '(8 4 92 82 8 13)) => '(9 5 93 83 9 14))

(check-report)
(check-reset!)
