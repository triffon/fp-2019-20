(require rackunit rackunit/text-ui)

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (zero? n)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

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
