(load "./binary-tree.scm")



(load "../testing/check.scm")

(define (square x) (* x x))
(define (cube x) (* x x x))

(check (map-tree square '()) => '())
(check (map-tree square '(4 () ())) => '(16 () ()))
(check (map-tree square '(1 (2 (4 () ()) (5 () ())) (3 () ())))
       => '(1 (4 (16 () ()) (25 () ())) (9 () ())))
(check (map-tree cube '(1 (2 (4 () ()) (5 () ())) (3 () ())))
       => '(1 (8 (64 () ()) (125 () ())) (27 () ())))

(check-report)
(check-reset!)
