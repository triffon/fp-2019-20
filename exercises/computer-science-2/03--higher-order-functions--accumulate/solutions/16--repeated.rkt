#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 16
; Напишете функция `(repeated f n)` която  връща `n`-кратното прилагане на f.

(define (twice f x) (f (f x)))
(define (compose f g) (lambda (x) (f (g x))))

(define (id x) x)

(define (repeated f n)
  (if (= n 0)
      id
      (compose f (repeated f (- n 1)))))


(define (1+ n) (+ 1 n))

(run-tests (test-suite "repeated tests"
             (check-eq? ((repeated 1+ 19) 0)
                        19))
           'verbose)

