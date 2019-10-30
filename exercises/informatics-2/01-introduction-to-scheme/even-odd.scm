(require rackunit rackunit/text-ui)

; Изрично връщаме #t или #f
(define (even? x)
  (if (= 0 (remainder x 2))
      #t
      #f))

; Просто връщаме стойността на логическия оператор, която може да е #t или #f
(define (odd? x)
  (not (even? x)))

(define even-odd-tests
  (test-suite
   "Tests for even and odd"

   (check-true (even? 0))
   (check-true (even? 2))
   (check-false (even? 1))
   (check-false (even? 3))

   (check-false (odd? 0))
   (check-false (odd? 2))
   (check-true (odd? 1))
   (check-true (odd? 3))))

(run-tests even-odd-tests)
