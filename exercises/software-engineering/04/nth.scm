(define (nth l n)
  (if (= n 0)
      (car l)
      (nth (cdr l) (- n 1))))

(load "../testing/check.scm")

(check (nth '(2) 0) => 2)
(check (nth '(1 2) 0) => 1)
(check (nth '(1 2) 1) => 2)
(check (nth '(3 4 1) 0) => 3)
(check (nth '(3 4 1) 1) => 4)
(check (nth '(3 4 1) 2) => 1)
(check (nth '(5 3 5 5) 3) => 5)
(check (nth '(42 4 82 12 31 133) 4) => 31)

(check-report)
(check-reset!)
