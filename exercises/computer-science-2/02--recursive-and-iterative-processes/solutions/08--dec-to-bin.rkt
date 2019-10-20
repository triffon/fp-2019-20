#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 8
; Напишете функция, която преобразува число от десетична в двоична бройна система.

(define (dec-to-bin n)
  (if (< n 2)
      n
      (+ (* 10 (dec-to-bin (quotient n 2)))
         (remainder n 2))))

(run-tests (test-suite "count-digits tests"
                       (check-eq? (dec-to-bin 0) 0)
                       (check-eq? (dec-to-bin 1) 1)
                       (check-eq? (dec-to-bin 4) 100)
                       (check-eq? (dec-to-bin 31) 11111)
                       (check-eq? (dec-to-bin 64) 1000000))
           'verbose)

