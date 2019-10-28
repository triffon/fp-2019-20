(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (iter a b c counter)
    (if (= counter n)
        a
        (iter b
              c
              (+ c
                 (* 2 b)
                 (* 3 a))
              (+ counter 1))))

  (iter 0 1 2 0))

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
