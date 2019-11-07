#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 10
; Напишете функция `(filter pred? L)`,
; която връща списък от елементите на `L`, за които `pred?` е истина.

(define (filter p? L)
  (cond ((null? L) L)
        ((p? (car L)) (cons (car L) (filter p? (cdr L))))
        (else (filter p? (cdr L)))))


(run-tests (test-suite "filter tests"
             (check-equal? (filter odd? '())
                           '())
             (check-equal? (filter odd? '(1 2 3 4 5 6))
                           '(1 3 5))
             (check-equal? (filter pair? '(1 (2 3) 4 ((5)) 6))
                           '((2 3) ((5))))
             (check-equal? (filter procedure? 
                                   (list 1 '(2 3) + 4 '((5)) 6 pair? filter))
                           (list + pair? filter)))
           'verbose)

