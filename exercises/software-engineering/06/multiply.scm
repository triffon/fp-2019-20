

(load "../testing/check.scm")

(check (multiply '((2)) '((21))) => '((42)))
(check (multiply '((1) (2)) '((21))) => '((21) (42)))
(check (multiply '((0 21)) '((1) (2))) => '((42)))
(check (multiply '((1 2 3) (3 2 1) (1 2 3)) '((4 5 6) (6 5 4) (4 6 5)))
       =>'((28 33 29) (28 31 31) (28 33 29)))

(check-report)
(check-reset!)
