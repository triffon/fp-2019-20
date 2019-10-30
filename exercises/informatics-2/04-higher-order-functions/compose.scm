(require rackunit rackunit/text-ui)

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (identity x) x)
(define (inc x) (+ x 1))
(define (square x) (* x x))

(define compose-tests
  (test-suite
    "Tests for compose"

    (check = ((compose identity identity) 0) 0)
    (check = ((compose identity inc) 0) 1)
    (check = ((compose inc identity) 0) 1)

    (check = ((compose inc inc) 0) 2)
    (check = ((compose square square) 2) 16)

    (check = ((compose square inc) 6) 49)
    (check = ((compose inc square) 6) 37)

    (check = ((compose (compose square inc) inc) 6) 64)))

(run-tests compose-tests)
