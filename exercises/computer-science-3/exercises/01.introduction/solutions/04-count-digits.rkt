#lang racket
(require rackunit)
(require rackunit/text-ui)
; 1.5 - Търсим процедура, която намира броя цифри на дадено число
; Трябва да работи и за отрицателни числа.

(define (abs n)
  (if (< n 0)
      (* -1 n)
      n
  )
)

(define (count-digits number)
  (if (and (<= 0 (abs number)) (>= 9 (abs number)))
      1
      (if (not (= 0 number)) ; това май го покриваме в горната проверка
          (+ 1 (count-digits (floor (/ (abs number) 10))))
          1
      )
  )
)

(define (count-digits2 number)
  (if (< (abs number) 10)
      1
      (+ 1 (count-digits2 (abs (quotient number 10))))))

(define (count-digits-iter number)
  (define (count-digits-iter-helper number result)
    (if (< (abs number) 10)
        (+ result 1)
        (count-digits-iter-helper (abs (quotient number 10)) (+ result 1))))
  (count-digits-iter-helper number 0))

(define tests
  (test-suite
    "Count digits tests"

    (test-case "Should count correctly"
      (check-equal? (count-digits 1024) 4)
    )
    (test-case "Should work alright with negative numbers"
      (check-equal? (count-digits -987421245) 9)
    )
    (test-case "Should work alright with digits"
      (check-equal? (count-digits 9) 1)
      (check-equal? (count-digits 0) 1)
    )
  )
)


(run-tests tests 'verbose)
