#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 3
; Напишете функция `reverse-num`, която обръща реда на цифрите на дадено число.

(define (reverse-num n) void)

(run-tests (test-suite "count-digits tests"
                       (check-eq? (reverse-num 12305) 50321)
                       (check-eq? (reverse-num 10000) 1)
                       (check-eq? (reverse-num -1093) -3901)
                       (check-eq? (reverse-num 10000001) 10000001))
           'verbose)

