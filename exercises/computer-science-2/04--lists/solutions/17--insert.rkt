#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 17
; Напишете функция `(insert n x L)`,
; която вмъква `x` на позиция `n` в списъка `L`, без да премахва останалите елементи.

(define (insert n x L)
  (cond ((null? L) (list x))
        ((= n 0) (cons x L))
        (else (cons (car L) (insert (- n 1) x (cdr L))))))


(run-tests (test-suite "insert tests"
             (check-equal? (insert 0 3.14 '(1 2 3 4))
                           '(3.14 1 2 3 4))
             (check-equal? (insert 3 3.14 '(21 22 23 24))
                           '(21 22 23 3.14 24))
             (check-equal? (insert 1 3.14 '(1 (2 3 4) (5 6) ((7)) 8))
                           '(1 3.14 (2 3 4) (5 6) ((7)) 8)))
           'verbose)

