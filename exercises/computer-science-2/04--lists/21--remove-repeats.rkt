#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 21
; Напишете функция `(remove-repeats L)`,
; която премахва последователните повторения на едно и също число от списъка `L`.

(define (remove-repeats L)
  (void))


(run-tests (test-suite "remove-repeats tests"
             (check-equal? (remove-repeats '())
                           '())
             (check-equal? (remove-repeats '(5))
                           '(5))
             (check-equal? (remove-repeats '(1 1 4 4 3 3 4 4 4))
                           '(1 4 3 4))
             (check-equal? (remove-repeats '(1 2 3 4))
                           '(1 2 3 4)))
           'verbose)

