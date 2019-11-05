

(load "../testing/check.scm")

(check (prime-sum-pairs 1) => '())
(check (prime-sum-pairs 2) => '((2 1 3)))
(check (prime-sum-pairs 6) => '((2 1 3)
                                (3 2 5)
                                (4 1 5)
                                (4 3 7)
                                (5 2 7)
                                (6 1 7)
                                (6 5 11)))

(check-report)
(check-reset!)
