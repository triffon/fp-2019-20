(define (juxt . fns)
  (lambda args
    (map (lambda (fn)
           (apply fn args))
         fns)))

(load "../testing/check.scm")

(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (double x) (* 2 x))
(define (square x) (* x x))

(check ((juxt) 5) => '())
(check ((juxt list) 1 2 3) => '((1 2 3)))
(check ((juxt inc dec double square) 5) => '(6 4 10 25))
(check ((juxt + *) 3 4 5) => '(12 60))

(check-report)
(check-reset!)
