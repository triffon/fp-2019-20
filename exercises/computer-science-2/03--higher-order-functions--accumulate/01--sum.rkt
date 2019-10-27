#lang racket
(require rackunit rackunit/text-ui)


; ### Задача 1
; Напишете функция `(sum-step a b next)`,
; която изчислява сумата на числата
; `a`, `(next a)`, `(next (next a))`, ..., `b`.

(define (sum-step a b next)
  void)

; Напишете функция `(sum-term a b term)`,
; която изчислява сумата на числата
; `(term a)`, `(term (+ 1 a))`, `(term (+ 1 (+ 1 a)))`, ..., `(term b)`.

(define (sum-term a b term)
  void)

; Напишете функция `(sum a b term next)`,
; която изчислява сумата на числата
; `(term a)`, `(term (next a))`, `(term (next (next a)))`, ..., `(term b)`.

(define (sum a b term next)
  void)


(define (1+ n) (+ 1 n))
(define (2+ n) (+ 2 n))
(define (id x) x)
(define (sq x) (* x x))

(run-tests (test-suite "sum implementations tests"
             (test-suite "sum-step tests"
               (check-eq? (sum-step 1 5 2+)
                          9)
               (check-eq? (sum-step 1 6 2+)
                          9)
               (check-eq? (sum-step -5 -1 2+)
                          -9)
               (check-eq? (sum-step 5 1 2+)
                          0))
             (test-suite "sum-term tests"
               (check-eq? (sum-term 1 5 sq)
                          55)
               (check-eq? (sum-term -5 -1 sq)
                          55)
               (check-eq? (sum-term 5 1 sq)
                          0))
             (test-suite "sum tests"
               (check-eq? (sum 1 5 id 2+)
                          9)
               (check-eq? (sum 1 6 id 2+)
                          9)
               (check-eq? (sum -5 -1 id 2+)
                          -9)
               (check-eq? (sum 5 1 id 2+)
                          0)
             
               (check-eq? (sum 1 5 sq 1+)
                          55)
               (check-eq? (sum -5 -1 sq 1+)
                          55)
               (check-eq? (sum 5 1 sq 1+)
                          0)
             
               (check-eq? (sum 1 5 sq 2+)
                          35)
               (check-eq? (sum -5 -1 sq 2+)
                          35)
               (check-eq? (sum 5 1 sq 2+)
                          0)))
           'verbose)

