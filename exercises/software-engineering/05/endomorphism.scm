(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (endomorphism? l op f)
  (define (image-in-l? x)
    (member (f x) l))

  (define (f-preserves-op? x y)
    (= (op (f x) (f y))
       (f (op x y))))

  (and (every? image-in-l? l)
       (every? (lambda (x)
                 (every? (lambda (y)
                           (f-preserves-op? x y))
                         l))
               l)))

(load "../testing/check.scm")

(check (endomorphism? '() + (lambda (x) (remainder x 3))) => #t)
(check (endomorphism? '(0 1 4 6) + (lambda (x) x)) => #t)
(check (endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3))) => #t)
(check (endomorphism? '(0 1 4 5 6) + (lambda (x) (remainder x 3))) => #f)
(check (endomorphism? '(0 1 4 6) expt (lambda (x) (+ x 1))) => #f)

(check-report)
(check-reset!)
