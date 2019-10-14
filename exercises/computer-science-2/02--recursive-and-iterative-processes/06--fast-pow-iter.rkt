#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 6
; Напишете итеративен вариант на `fast-pow` от миналото упражнение

(define (fast-pow x n) void)

(run-tests (test-suite "count-digits tests"
                       (check-eq? (fast-pow 10 4) 10000)
                       (check-eq? (fast-pow 5 3) 125)
                       (check-eq? (fast-pow -5 3) -125)
                       (check-eq? (fast-pow -5 0) 1))
           'verbose)

