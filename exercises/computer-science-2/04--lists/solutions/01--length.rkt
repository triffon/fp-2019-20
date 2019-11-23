#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 1
; Напишете функция `(length L)`,
; която намира дължина на списък.

(define (length L)
  (if (null? L)
      0
      (+ 1 (length (cdr L)))))


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests (test-suite "length tests"
             (check-eq? (length '())
                        0)
             (check-eq? (length l1)
                        8)
             (check-eq? (length l2)
                        3))
           'verbose)

