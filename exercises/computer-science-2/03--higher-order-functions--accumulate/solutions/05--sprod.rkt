#lang racket
(require rackunit rackunit/text-ui)

(require "04--product.rkt" "03--my-sin--my-cos.rkt")

(define (1+ n) (+ 1 n))

; ### Задача 5
; Напишете функция `(sprod p x)`, която изчислява следното произведение:
; Π(x - (x^3)/3! + (x^5)/5! - ... + (-1)^k * (x^(2k+1)) / (2k+1)!
; където 1 <= k <= p

(define (sprod p x)
  (product 1
           p
           (lambda (k) (my-sin k x))
           1+))


(define (2+ n) (+ 2 n))
(define (sq x) (* x x))

(run-tests (test-suite "sprod tests"
             (check-eq? (sprod 15 0) 0)
             (check-= (sprod 3 1) 0.5901 0.001))
           'verbose)

