(require rackunit rackunit/text-ui)

(define (square x) (* x x))

; На всяка стъпка делим степента exponent на 2, която
; аналогично на другите задачи ни служи като "counter".
; Понеже делим на 2 степента, трябва да умножим по 2 базата base.
; Има специален случай, в който степента може да е нечетно число >= 3.
(define (fast-expt-iter x n)
  (define (helper result base exponent)
    (cond ((= exponent 0) result)
          ((= exponent 1) (* result base))
          ((even? exponent)
            (helper result
                    (square base)
                    (quotient exponent 2)))
          ((odd? exponent)
            (helper (* base result)
                    (square base)
                    (quotient (- exponent 1) 2)))))

  (helper 1 x n))

(define fast-expt-iter-tests
  (test-suite
   "Tests for fast-expt-iter"

   (check = (fast-expt-iter 2 0) 1)
   (check = (fast-expt-iter 2 1) 2)
   (check = (fast-expt-iter 2 2) 4)
   (check = (fast-expt-iter 3 2) 9)
   (check = (fast-expt-iter 5 3) 125)
   (check = (fast-expt-iter 2 10) 1024)
   (check = (fast-expt-iter -2 10) 1024)
   (check = (fast-expt-iter -2 11) -2048)))

(run-tests fast-expt-iter-tests)
