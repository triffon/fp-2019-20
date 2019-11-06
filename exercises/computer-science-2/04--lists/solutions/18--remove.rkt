#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 18
; Напишете функция `(remove x L)`,
; която премахва първото срещане на `x` в `L` (връщайки нов списък).

(define (remove x L)
  (cond ((null? L) L)
        ((equal? x (car L)) (cdr L))
        (else (cons (car L) (remove x (cdr L))))))


(run-tests (test-suite "remove tests"
             (check-equal? (remove 3 '(1 2 3 4))
                           '(1 2 4))
             (check-equal? (remove 2 '(1 2 3 2 4 2 2))
                           '(1 3 2 4 2 2))
             (check-equal? (remove '(5 6) '(1 (2 3 4) (5 6) ((7)) (5 6)))
                           '(1 (2 3 4) ((7)) (5 6))))
           'verbose)

