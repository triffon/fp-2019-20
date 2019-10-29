

(load "../testing/check.scm")

(check (scale '() 42) => '())
(check (scale '(42) 1) => '(42))
(check (scale '(1 2 3 4) 2) => '(2 4 6 8))
(check (scale '(8 4 92 82 8 13) 0) => '(0 0 0 0 0 0))
(check (scale '(8 4 92 82 8 13) 3) => '(24 12 276 246 24 39))

(check-report)
(check-reset!)
