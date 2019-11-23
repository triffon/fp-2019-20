#lang racket
(require rackunit rackunit/text-ui)

(require "19--explode-digits.rkt")

; ### Задача 20
; Напишете функция `(digit-occurence d n)`,
; която намира колко пъти цифрата `d` се среща в цялото число `n`.
; Използвайте `digit-occurence`.

(define (digit-occurence d n)
  (length (filter (lambda (x)
                    (= x d))
                  (explode-digits n))))


(run-tests (test-suite "digit-occurence tests"
             (check-equal? (digit-occurence 0 0)
                           1)
             (check-equal? (digit-occurence 2 122342)
                           3)
             (check-equal? (digit-occurence 0 1000)
                           3))
           'verbose)

