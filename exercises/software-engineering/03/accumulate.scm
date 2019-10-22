

(load "../testing/check.scm")

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(check (accumulate + 0 identity 1 1+ 5) => 15)
(check (accumulate + 0 square 1 1+ 5) => 55)
(check (accumulate * 0 identity 1 1+ 5) => 0)
(check (accumulate * 1 identity 0 1+ 5) => 0)
(check (accumulate * 1 identity 1 1+ 5) => 120)
(check (accumulate (lambda (x acc)
                     (if (even? x) (1+ acc) acc))
                   0
                   identity
                   0 1+ 10)
       => 6)
(check (accumulate +
                   0
                   (lambda (x)
                     (if (even? x) 1 0))
                   0 1+ 10)
       => 6)

(check (accumulate-iter + 0 identity 1 1+ 5) => 15)
(check (accumulate-iter + 0 square 1 1+ 5) => 55)
(check (accumulate-iter * 0 identity 1 1+ 5) => 0)
(check (accumulate-iter * 1 identity 0 1+ 5) => 0)
(check (accumulate-iter * 1 identity 1 1+ 5) => 120)
(check (accumulate-iter (lambda (acc x)
                          (if (even? x) (1+ acc) acc))
                        0
                        identity
                        0 1+ 10)
       => 6)
(check (accumulate-iter +
                        0
                        (lambda (x)
                          (if (even? x) 1 0))
                        0 1+ 10)
       => 6)

(check (sum identity 1 1+ 5) => 15)
(check (sum square 1 1+ 5) => 55)
(check (sum (lambda (x)
              (if (even? x) 1 0))
            0 1+ 10)
       => 6)

(check (product identity 0 1+ 5) => 0)
(check (product identity 1 1+ 5) => 120)
(check (product (lambda (x)
                  (if (even? x) x 1))
                1 1+ 10)
       => 3840)

(check-report)
(check-reset!)
