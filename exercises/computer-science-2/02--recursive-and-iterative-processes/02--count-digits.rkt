#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 2
; Напишете функция `count-digits`, която намира броя цифри на дадено цяло число (което може да е отрицателно).

(define (count-digits n) void)

(run-tests (test-suite "count-digits tests"
                       (check-eq? (count-digits 12345) 5)
                       (check-eq? (count-digits 0) 1)
                       (check-eq? (count-digits -1009) 4)
                       (check-eq? (count-digits 1000000) 7))
           'verbose)

