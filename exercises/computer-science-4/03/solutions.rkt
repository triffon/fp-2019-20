#lang racket

; the identity function is not in R5RS
(define (id x) x)

; 1-sum-term
(define (sum-term from to term acc)
  (if (> from to)
    acc
    (sum-term (+ from 1)
                to
                term
                (+ acc (term from)))))

; 2-accumulate
(define (accumulate from to step term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 step
                 term
                 (step acc (term from)))))

; 3-factorial
(define (fact n)
  (accumulate 1 n * id 1))

; 4-count-p
(define (count-p from to p)
  (define (inc-if acc x)
      (if (p x) (+ acc 1) acc))
  (accumulate from to inc-if id 0))

; 5-for-all?
(define (for-all? from to p)
  (define (and2 a b)
    (and a b))
  (accumulate from to and2 p #t))

; 6-exists?
(define (exists? from to p)
  (define (or2 a b)
    (or a b))
  (accumulate from to or2 p #f))

; 7-complement
(define (complement p)
  (lambda (x) (not (p x))))

; 8-flip
(define (flip f)
  (lambda (x y) (f y x)))

; 9-double
(define (double f)
  (lambda (x) (f (f x))))

; 10-compose
(define (compose f g)
  (lambda (x) (f (g x))))

; 11-repeat
(define (repeat f n)
  (if (zero? n)
    id (lambda (x)
      (f ((repeat f (- n 1)) x)))))

