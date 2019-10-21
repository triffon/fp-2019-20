(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(load "../testing/check.scm")

(check (factorial 0) => 1)
(check (factorial 1) => 1)
(check (factorial 2) => 2)
(check (factorial 3) => 6)
(check (factorial 4) => 24)
(check (factorial 5) => 120)
(check (factorial 6) => 720)
(check (factorial 7) => 5040)

(check-report)
(check-reset!)
