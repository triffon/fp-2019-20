#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 15
; Напишете функция `(flip f)`, която разменя аргументите на f.

(define (flip f)
  (lambda (x y)
    (f y x)))


(run-tests (test-suite "flip tests"
             (check-eq? ((flip expt) 2 5)
                        25)
             (check-eq? ((flip remainder) 10 3)
                        3))
           'verbose)

