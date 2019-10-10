(require rackunit rackunit/text-ui)

; TODO: repeated

(define (identity x) x)
(define (inc x) (+ x 1))
(define (square x) (* x x))

(define repeated-tests
  (test-suite
    "Tests for repeated"

    (check = ((repeated identity 0) 0) 0)
    (check = ((repeated identity 5) 1) 1)

    (check = ((repeated inc 0) 5) 5)
    (check = ((repeated inc 5) 0) 5)
    (check = ((repeated inc 5) 5) 10)

    (check = ((repeated square 0) 5) 5)
    (check = ((repeated square 1) 5) 25)
    (check = ((repeated square 2) 5) 625)))

(run-tests repeated-tests)
