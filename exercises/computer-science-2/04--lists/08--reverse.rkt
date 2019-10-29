#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 8
; Напишете функция `(reverse L)`,
; която връща списък от елементите на `L` в обратен ред.

(define (reverse L)
  (void))


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests (test-suite "reverse tests"
             (check-equal? (reverse '())
                           '())
             (check-equal? (reverse l1)
                           '(8 7 6 5 4 3 2 1))
             (check-equal? (reverse l2)
                           '((21 22) (12 13) 0))
             (check-equal? (reverse (reverse l1))
                           l1)
             (check-equal? (reverse (reverse l2))
                           l2))
           'verbose)

