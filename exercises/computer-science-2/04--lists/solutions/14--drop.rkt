#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 14
; Напишете функция `(drop n L)`,
; която връща списък от всички елемента на `L` без първите `n`.

(define (drop n L)
  (if (or (null? L)
          (= n 0))
      L
      (drop (- n 1) (cdr L))))


(run-tests (test-suite "drop tests"
             (check-equal? (drop 0 '())
                           '())
             (check-equal? (drop 0 '(1 2 3 4))
                           '(1 2 3 4))
             (check-equal? (drop 3 '(2 2 2 2))
                           '(2))
             (check-equal? (drop 3 '(1 (2 3 4) (5 6) ((7)) 8))
                           '(((7)) 8)))
           'verbose)

