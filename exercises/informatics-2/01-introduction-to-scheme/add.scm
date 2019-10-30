(require rackunit rackunit/text-ui)

; Главата и тялото на процедурата се различават само по add и +
(define (add a b) (+ a b))

; Можем директно да кажем, че add е същото като +
(define add +)

(define add-tests
  (test-suite
   "Tests for add"

   (check = (add 1 2) 3)
   (check = (add 1 1) 2)
   (check = (add 0 1) 1)
   (check = (add 4 -2) 2)
   (check = (add -4 2) -2)))

(run-tests add-tests)
