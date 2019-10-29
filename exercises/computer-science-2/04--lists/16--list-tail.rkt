#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 16
; Напишете функция `(list-tail L n)`,
; която връща списък от всички елементи на позиция по-голяма от `n` в списъка `L`.

(define (list-tail L n)
  (void))


(run-tests (test-suite "list-tail tests"
             (check-equal? (list-tail '(1 2 3 4) 0)
                           '(2 3 4))
             (check-equal? (list-tail '(21 22 23 24) 3)
                           '())
             (check-equal? (list-tail '(1 (2 3 4) (5 6) ((7)) 8) 1)
                           '((5 6) ((7)) 8)))
           'verbose)

