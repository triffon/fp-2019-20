

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
