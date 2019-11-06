#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 13
; Напишете функция `(take n L)`,
; която връща списък от първите `n` елемента на `L`.

(define (take n L)
  (if (or (null? L)
          (= n 0))
      '()
      (cons (car L) (take (- n 1) (cdr L)))))


(run-tests (test-suite "take tests"
             (check-equal? (take 0 '())
                           '())
             (check-equal? (take 0 '(1 2 3 4))
                           '())
             (check-equal? (take 3 '(2 2 2 2))
                           '(2 2 2))
             (check-equal? (take 3 '(1 (2 3 4) (5 6) ((7))))
                           '(1 (2 3 4) (5 6))))
           'verbose)

