#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 9
; Напишете функция `subnum?`, която проверява дали записа на дадено число се съдържа в записа на друго дадено число.

(define (ends-with k n)
  (cond ((< k 10) (= k (remainder n 10)))
        ((< n 10) #f)
        ((= (remainder k 10) (remainder n 10))
         (ends-with (quotient k 10) (quotient n 10)))
        (else #f)))

(define (subnum? k n)
  (if (< n 0)
      (subnum? k (- n))
      (and (and (<= k n) (>= k 0))
           (or (ends-with k n)
               (subnum? k (quotient n 10))))))

(run-tests (test-suite "count-digits tests"
                       (check-true (subnum? 0 0))
                       (check-true (subnum? 2045 2045))
                       (check-true (subnum? 3 1234))
                       (check-true (subnum? 5678 123456789))
                       (check-false (subnum? 45 1234))
                       (check-false (subnum? 321 1234))
                       (check-false (subnum? 5679 123456789))
                       (check-true (subnum? 3 -1234))
                       (check-false (subnum? -3 1234))
                       (check-false (subnum? -3 -1234)))
           'verbose)

