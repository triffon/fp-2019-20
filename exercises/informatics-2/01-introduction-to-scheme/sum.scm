(require rackunit rackunit/text-ui)

; Скъсяваме интервала [start, end] отляво, докато не остане само 1 елемент
(define (sum start end)
  (if (= start end)
      end
      (+ start
         (sum (+ start 1) end))))

(define sum-tests
  (test-suite
   "Tests for sum"

   (check = (sum 1 1) 1)
   (check = (sum 1 2) 3)
   (check = (sum 1 3) 6)
   (check = (sum 0 4) 10)
   (check = (sum -4 2) -7)))

(run-tests sum-tests)
