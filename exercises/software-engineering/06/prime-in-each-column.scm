(define (divides? k n)
  (= (remainder n k) 0))

(define (prime? n)
  (define (iter k)
    (or (= k n)
        (and (not (divides? k n))
             (iter (+ k 1)))))

  (and (not (= n 1)) (iter 2)))

(define (prime-in-each-column? matrix)
  (define (prime-exists? l)
    (any? prime? l))

  (for-all-columns? prime-exists? matrix))

(load "../testing/check.scm")

(check (prime-in-each-column? '((1))) => #f)
(check (prime-in-each-column? '((1) (2))) => #t)
(check (prime-in-each-column? '((1 2 3))) => #f)
(check (prime-in-each-column? '((1 2 3) (2 3 4))) => #t)
(check (prime-in-each-column? '((17 2 16) (4 5 3))) => #t)
(check (prime-in-each-column? '((1 2 3) (4 5 6) (7 8 9))) => #t)
(check (prime-in-each-column? '((1 2 3) (4 5 6) (42 8 9))) => #f)

(check-report)
(check-reset!)
