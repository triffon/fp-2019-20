#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 3
; Напишете функция `(last L)`,
; която намира последния елемент на списък.

(define (last L)
  (if (null? (cdr L))
      (car L)
      (last (cdr L))))


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests (test-suite "last tests"
             (check-eq? (last '(5))
                        5)
             (check-eq? (last l1)
                        8)
             (check-equal? (last l2)
                           '(21 22)))
           'verbose)

