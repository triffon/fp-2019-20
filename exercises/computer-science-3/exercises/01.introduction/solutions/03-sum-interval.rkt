#lang racket
(require rackunit)
(require rackunit/text-ui)
; 1.4 - Съчинете процедура, която намира сумата на числата в даден затворен интервал.

(define (sum-interval start end)
  (if (<= start end)
      (+ end (sum-interval start (- end 1)))
      0
  )
)

(define (sum-interval-iter start end)
  (define (sum-interval-iter-helper start end result)
    (if (<= start end)
        result
        (sum-interval-iter-helper (+ start 1) end (+ result start))))
  (sum-interval start end 0))

(define tests
  (test-suite
    "Interval sum tests"

    (test-case "start < end"
     (check-equal? (sum-interval 1 100) 5050)
    )
    (test-case "start > end"
     (check-equal? (sum-interval 500 150) 0)
    )
    (test-case "start = end"
     (check-equal? (sum-interval 9 9) 9)
    )
    (test-case "negative numbers :O"
     (check-equal? (sum-interval -10 0) -55)
    )
  ))

(run-tests tests 'verbose)
