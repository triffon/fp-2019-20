#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 19
; Напишете функция `(explode-digits n)`,
; която по дадено цяло число `n`, връща списък от цифрите му.

(define (explode-digits n)
  (void))


(run-tests (test-suite "explode-digits tests"
             (check-equal? (explode-digits 0)
                           '(0))
             (check-equal? (explode-digits 1234)
                           '(1 2 3 4))
             (check-equal? (explode-digits 1000)
                           '(1 0 0 0)))
           'verbose)

