#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 4
; Напишете функция `(append L M)`,
; която по списъци `L = (a1 a2 ... an)` и `M = (b1 b1 ... bm)` връща списък `(а1 a2 ... an b1 b2 ... bm)`.

(define (append L M)
  (if (null? L)
      M
      (cons (car L) (append (cdr L) M))))


(run-tests (test-suite "append tests"
             (check-equal? (append '(1 2 3) '(4 5 6))
                           '(1 2 3 4 5 6))
             (check-equal? (append '() '(4 5 6))
                           '(4 5 6))
             (check-equal? (append '(1 2 3) '())
                           '(1 2 3))
             (check-equal? (append '() '())
                           '())
             (check-equal? (append '((1) (2 3)) '((5 6 7) ((8))))
                           '((1) (2 3) (5 6 7) ((8)))))
           'verbose)

