#lang racket

(provide from-numeral
         to-numeral
         plus
         mult
         pred)

(define zero (lambda (f v) v))

(define (succ n)
  (lambda (f v)
    (f (n f v))))

(define (from-numeral n) void)

(define (to-numeral n) void)

(define (plus n m) void)

(define (mult n m) void)

(define (pred n) void)
