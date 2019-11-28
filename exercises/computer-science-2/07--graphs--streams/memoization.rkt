#lang racket
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (foo1 x)
  (define bar (delay (fib 30)))
  (force bar)
  (+ x (force bar)))

(define (foo2 x)
  (define bar (delay (fib 30)))
  (fib 30)
  (+ x (force bar)))

; стойността на bar е мемоизирана
(define (foo3 x)
  (define bar (delay (fib 30)))
  (force bar)
  (set! fib (lambda (x) x))
  (+ x (force bar)))

(define (foo4 x)
  (define bar (delay (fib 30)))
  (set! fib (lambda (x) x))
  (force bar)
  (+ x (force bar)))
