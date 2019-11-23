

(load "../testing/check.scm")

(check (zip '() '()) => '())
(check (zip '(42) '()) => '())
(check (zip '(1 3 5) '(2 4 6)) => '((1 2) (3 4) (5 6)))
(check (zip '(1 3 5) '(2 4 6 8)) => '((1 2) (3 4) (5 6)))

(check (zip-with + '() '()) => '())
(check (zip-with + '(42) '()) => '())
(check (zip-with + '(1 3 5) '(2 4 6)) => '(3 7 11))
(check (zip-with + '(1 3 5) '(2 4 6 8)) => '(3 7 11))

(check (zip-with* + '() '() '()) => '())
(check (zip-with* + '(42) '() '(1 2 3)) => '())
(check (zip-with* + '(1 2 3) '(4 5 6) '(7 8 9)) => '(12 15 18))
(check (zip-with* cons '(1 3 5) '(2 4 6 8 10)) => '((1 . 2) (3 . 4) (5 . 6)))

(check-report)
(check-reset!)
