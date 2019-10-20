#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 9
; Напишете функция `subnum?`, която проверява дали записа на дадено число се съдържа в записа на друго дадено число.

(define (subnum? k n) void)

(run-tests (test-suite "count-digits tests"
                       (check-true (subnum? 0 0))
                       (check-true (subnum? 2045 2045))
                       (check-true (subnum? 3 1234))
                       (check-true (subnum? 5678 123456789))
                       (check-false (subnum? 45 1234))
                       (check-false (subnum? 321 1234))
                       (check-false (subnum? 5679 123456789))
                       (check-true (subnum? 3 -1234))
                       (check-false (subnum? -3 1234))
                       (check-false (subnum? -3 -1234)))
           'verbose)

