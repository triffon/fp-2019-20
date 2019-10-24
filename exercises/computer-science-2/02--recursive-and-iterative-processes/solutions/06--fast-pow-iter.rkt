#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 6
; Напишете итеративен вариант на `fast-pow` от миналото упражнение

(define (fast-pow-iter x n)
  (define (for y i result)
    (if (= i 0)
        result
        (if (even? i)
            (for (* y y) (/ i 2) result)
            (for y (- i 1) (* result y)))))
  (if (< n 0)
      (/ 1 (for x (- n) 1))
      (for x n 1)))


(run-tests (test-suite "count-digits tests"
                       (check-eq? (fast-pow-iter 10 4) 10000)
                       (check-eq? (fast-pow-iter 5 3) 125)
                       (check-eq? (fast-pow-iter -5 3) -125)
                       (check-eq? (fast-pow-iter -5 4) 625)
                       (check-eq? (fast-pow-iter -5 0) 1))
           'verbose)

