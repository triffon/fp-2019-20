(define (foldr operation null-value l)
  (if (null? l)
      null-value
      (operation (car l)
                 (foldr operation null-value (cdr l)))))

(define (foldl operation null-value l)
  (if (null? l)
      null-value
      (foldl operation
             (operation null-value (car l))
             (cdr l))))

(load "../testing/check.scm")

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(check (foldr + 0 '()) => 0)
(check (foldr + 2 '(40)) => 42)
(check (foldr + 0 '(1 2 3 4)) => 10)
(check (foldr * 1 '(1 2 3 4 5)) => 120)
(check (foldr * 0 '(8 4 92 82 8 13)) => 0)

(check (foldl + 0 '()) => 0)
(check (foldl + 2 '(40)) => 42)
(check (foldl + 0 '(1 2 3 4)) => 10)
(check (foldl * 1 '(1 2 3 4 5)) => 120)
(check (foldl * 0 '(8 4 92 82 8 13)) => 0)

(check (map square '()) => '())
(check (map identity '(42)) => '(42))
(check (map 1+ '(41)) => '(42))
(check (map 1+ '(1 2 3 4)) => '(2 3 4 5))
(check (map square '(1 2 3 4 5)) => '(1 4 9 16 25))
(check (map identity '(8 4 92 82 8 13)) => '(8 4 92 82 8 13))
(check (map 1+ '(8 4 92 82 8 13)) => '(9 5 93 83 9 14))

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
