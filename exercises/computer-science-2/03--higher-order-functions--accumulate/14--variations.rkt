#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 14
; Напишете функция, която намира броя вариации на `n` елемента, `k`-ти клас.

(define (variations k n)
  void)

(run-tests (test-suite "variations tests"
             (check-eq? (variations 0 3)
                        1)
             (check-eq? (variations 1 15)
                        15)
             (check-eq? (variations 2 15)
                        210)
             (check-eq? (variations 5 15)
                        360360))
           'verbose)

