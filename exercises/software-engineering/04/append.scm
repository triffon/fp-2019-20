

(load "../testing/check.scm")

(check (append '() '()) => '())
(check (append '() '(42)) => '(42))
(check (append '(42) '()) => '(42))
(check (append '(42) '(1)) => '(42 1))
(check (append '(1 2 3 4) '(5 6)) => '(1 2 3 4 5 6))
(check (append '(1 2 3 4) '(4 4 4)) => '(1 2 3 4 4 4 4))
(check (append '(8 4 92 82 8 13) '(42 666 83)) => '(8 4 92 82 8 13 42 666 83))

(check-report)
(check-reset!)
