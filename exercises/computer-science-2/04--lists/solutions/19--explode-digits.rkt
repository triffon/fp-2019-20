#lang racket
(require rackunit rackunit/text-ui)

(provide explode-digits)

(define (push-back x L)
  (append L (list x)))

; ### Задача 19
; Напишете функция `(explode-digits n)`,
; която по дадено цяло число `n`, връща списък от цифрите му.

(define (explode-digits n)
  (cond ((< n 0) (explode-digits (- n)))
        ((< n 10) (list n))
        (else (push-back (remainder n 10)
                         (explode-digits (quotient n 10))))))


(run-tests (test-suite "explode-digits tests"
             (check-equal? (explode-digits 0)
                           '(0))
             (check-equal? (explode-digits 1234)
                           '(1 2 3 4))
             (check-equal? (explode-digits 1000)
                           '(1 0 0 0)))
           'verbose)

