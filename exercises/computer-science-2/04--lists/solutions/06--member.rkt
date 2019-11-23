#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 6
; Напишете функция `(member? x L)`,
; която намира дали `x` е елемент на списъка `L`.

(define (member? x L)
  (cond ((null? L) #f)
        ((equal? x (car L)) #t)
        (else (member? x (cdr L)))))



(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests (test-suite "member? tests"
             (check-true (member? 5 l1))
             (check-true (member? 1 l1))
             (check-true (member? '() '(())))
             (check-true (member? '(21 22)  l2))
             (check-false (member? 5 '()))
             (check-false (member? '() l1))
             (check-false (member? '(21) l2))
             (check-false (member? '(21 22 23) l2))
             (check-false (member? '(0) l2)))
           'verbose)

