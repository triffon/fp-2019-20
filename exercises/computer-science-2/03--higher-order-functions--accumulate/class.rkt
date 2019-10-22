#lang racket
(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(define (fact-iter n)
  (define (fact-helper i result)
    (if (= i n)
        (* result n)
        (fact-helper (+ i 1) (* result i))))
  (fact-helper 1 1))

(define (branch p? f g x)
  ((if (p? x) f g) x))




(define (sum-step-iter n m next)
  (define (help i result)
    (if (> i m)
        result
        (help (next i) (+ i result))))
  (help n 0))


(define (sum-interval-2 n m)
  (if (> n m)
      0
      (+ n (sum-interval-2 (+ 2 n) m))))


(define (sum-step a b next)
    (if (> a b)
      0
      (+ a (sum-step (next a) b next))))

(define (1+ n)
  (+ 1 n))


(define (2+ n)
  (+ 2 n))
(define (sq x) (* x x))


(define (sum-term a b term)
  (if (> a b)
      0
      (+ (term a) (sum-term (+ 1 a) b term))))

(define (sum a b term next)
  (if (> a b)
      0
      (+ (term a) (sum (next a) b term next))))


(define (example-term i)
  (/ (* (expt -1 i)
        (expt 50 i))
     (fact i)))


(define (p1 x)
  (sum-term 1 10 (lambda (i) (expt x i))))

(define (p2 x)
  (sum 1
       100
       (lambda (i) (* (expt x i)
                           (fact i)))
       1+))

(define (my-exp m x)
  (sum 0
       m
       (lambda (n) (/ (expt x n)
                      (fact n)))
       1+))

(define (my-sin2 m)
  (lambda (x)
    (sum 0
         m
         (lambda (n) (/ (* (expt -1 n)
                           (expt x (1+ (* 2 n))))
                        (fact (1+ (* 2 n)))))
         1+)))

(define good-enough-sin (my-sin2 15))
(define fast-sin (my-sin2 4))
(define accurate-sin (my-sin2 100))

;(define (sum a b term next)
;  (if (> a b)
;      0
;      (+ (term a) (sum (next a) b term next))))


(define (product a b term next)
  (if (> a b)
      1
      (* (term a) (product (next a) b term next))))

(define (accumulate operation null-value a b term next)
  (if (> a b)
      null-value
      (operation (term a)
                 (accumulate operation
                             null-value
                             (next a)
                             b
                             term
                             next))))

(define (sum2 a b term next)
  (accumulate + 0 a b term next))

(define (product2 a b term next)
  (accumulate * 1 a b term next))

(define (fact2 n)
  (accumulate * 1 1 n
              (lambda (i) i)
              1+))
(define (pow x n)
  (accumulate * 1 1 n
              (lambda (i) x)
              1+))

(define (accumulate-i operation null-value a b term next)
  (define (help i result)
    (if (> i b)
        result
        (help (next i) (operation result (term i)))))
  (help a null-value))


