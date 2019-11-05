(define (add-last l x)
  (if (null? l)
      (list x)
      (cons (car l)
            (add-last (cdr l) x))))

(load "../testing/check.scm")

(check (add-last '() 42) => '(42))
(check (add-last '(42) 1) => '(42 1))
(check (add-last '(1 2 3 4) 42) => '(1 2 3 4 42))
(check (add-last '(1 2 3 4) 4) => '(1 2 3 4 4))
(check (add-last '(8 4 92 82 8 13) 0) => '(8 4 92 82 8 13 0))

(check-report)
(check-reset!)
