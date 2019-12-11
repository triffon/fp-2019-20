#lang racket

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t)
     (cons h (delay t)))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (from a)
  (cons-stream a (from (+ a 1))))

(define head car)
(define (tail xs)
  (force (cdr xs)))

(define (first n xs)
  (if (= n 0)
      '()
      (cons (head xs)
            (first (- n 1)
                   (tail xs)))))
(define (repeat x)
  (cons-stream x (repeat x)))

(define ones (repeat 1))

(define ones*
  (cons-stream 1 ones*))

(define nats* (from 0))

(define (add-streams xs ys)
  (cons-stream (+ (head xs)
                  (head ys))
               (add-streams (tail xs)
                            (tail ys))))

(define nats
  (cons-stream 0
               (add-streams ones
                            nats)))

(define (fib n)
  (if (<= n 1)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (map f xs)
  (if (null? xs)
      '()
      (cons (f (car xs))
            (map f (cdr xs)))))

(define (map-stream f xs)
  (cons-stream (f (head xs))
               (map-stream f (tail xs))))


(define fibs* (map-stream fib nats))
(define fibs
  (cons-stream 0
    (cons-stream 1
      (add-streams fibs
                   (tail fibs)))))

(define (filter-stream p? xs)
  (if (p? (head xs))
      (cons-stream (head xs)
                   (filter-stream
                     p?
                     (tail xs)))
      (filter-stream p? (tail xs))))
(define (divides? d n) (= 0 (remainder n d)))
(define (sieve xs)
  (cons-stream (head xs)
               (sieve
                 (filter-stream
                   (lambda (y)
                     (not (divides?
                            (head xs)
                            y)))
                   xs))))
               
(define primes (sieve (from 2)))

