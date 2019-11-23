#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 5
; Напишете функция `(push-back x L)`,
; която слага `x` накрая на `L` (връщайки нов списък).

(define (push-back x L)
  (if (null? L)
      (cons x '())
      (cons (car L) (push-back x (cdr L)))))


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests (test-suite "push-back tests"
             (check-equal? (push-back 5 '(1 2))
                           '(1 2 5))
             (check-equal? (push-back 5 '())
                           '(5))
             (check-equal? (push-back '() '())
                           '(())))
           'verbose)

