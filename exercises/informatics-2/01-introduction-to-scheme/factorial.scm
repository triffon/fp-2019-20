(require rackunit rackunit/text-ui)

; Просто описваме формалната дефиница на факториел.
(define (factorial n)
  (if (<= n 1)
      1
      (* n
         (factorial (- n 1)))))

(define factorial-tests
  (test-suite
   "Tests for factorial"

   (check = (factorial 0) 1)
   (check = (factorial 1) 1)
   (check = (factorial 2) 2)
   (check = (factorial 3) 6)
   (check = (factorial 4) 24)
   (check = (factorial 5) 120)
   (check = (factorial 6) 720)
   (check = (factorial 7) 5040)))

(run-tests factorial-tests)
