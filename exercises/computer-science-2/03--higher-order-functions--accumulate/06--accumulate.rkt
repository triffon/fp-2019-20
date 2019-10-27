#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 6
; Напишете функцията `(accumulate operation null-value a b term next)`,
; която пресмята дясно натрупване.

(define (accumulate operation null-value a b term next)
  void)

; Напишете функцията `(accumulate-i operation null-value a b term next)`,
; която пресмята ляво натрупване.

(define (accumulate-i operation null-value a b term next)
  void)




(define (1+ n) (+ 1 n))
(define (2+ n) (+ 2 n))
(define (id x) x)
(define (sq x) (* x x))

(define (test-acc accumulate-impl impl-name)
  (test-suite (string-append impl-name " tests")
    (check-eq? (accumulate-impl * 1 1 5 sq 1+)
               14400)
    (check-eq? (accumulate-impl * 1 1 5 sq 2+)
               225)
    (check-eq? (accumulate-impl * 1 1 5 (lambda (x) (expt x 3)) 1+)
               1728000)
    (check-eq? (accumulate-impl * 1 1 5 (lambda (x) (expt x 3)) 2+)
               3375)

    (check-eq? (accumulate-impl + 0 1 5 id 2+)
               9)
    (check-eq? (accumulate-impl + 0 1 6 id 2+)
               9)
    (check-eq? (accumulate-impl + 0 -5 -1 id 2+)
               -9)
    (check-eq? (accumulate-impl + 0 5 1 id 2+)
               0)

    (check-eq? (accumulate-impl + 0 1 5 sq 1+)
               55)
    (check-eq? (accumulate-impl + 0 -5 -1 sq 1+)
               55)
    (check-eq? (accumulate-impl + 0 5 1 sq 1+)
               0)

    (check-eq? (accumulate-impl + 0 1 5 sq 2+)
               35)
    (check-eq? (accumulate-impl + 0 -5 -1 sq 2+)
               35)
    (check-eq? (accumulate-impl + 0 5 1 sq 2+)
               0)))

(run-tests (test-suite "accumulate implementations tests"
             (test-acc accumulate "accumulate")
             (test-acc accumulate-i "accumulate-i"))
           'verbose)

