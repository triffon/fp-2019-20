

(load "../testing/check.scm")

(check (f 0) => 0)
(check (f 1) => 1)
(check (f 2) => 2)
(check (f 3) => 4)
(check (f 4) => 11)
(check (f 5) => 25)
(check (f 6) => 59)
(check (f 7) => 142)

(check (f-iter 0) => 0)
(check (f-iter 1) => 1)
(check (f-iter 2) => 2)
(check (f-iter 3) => 4)
(check (f-iter 4) => 11)
(check (f-iter 5) => 25)
(check (f-iter 6) => 59)
(check (f-iter 7) => 142)

(check-report)
(check-reset!)
