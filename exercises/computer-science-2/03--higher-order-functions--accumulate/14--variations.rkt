#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 14
; Напишете функция, която намира броя вариации на `n` елемента, `k`-ти клас.

(define (variations k n)
  void)

(run-tests (test-suite "variations tests"
             (chech-eq? (variations 0 3)
                        1)
             (chech-eq? (variations 1 15)
                        15)
             (chech-eq? (variations 2 15)
                        210)
             (chech-eq? (variations 5 15)
                        360360))
           'verbose)

