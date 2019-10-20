(require rackunit rackunit/text-ui)



(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define map-tests
  (test-suite
    "Tests for map"

    (check-equal? (my-map '() square) '())
    (check-equal? (my-map '(42) identity) '(42))
    (check-equal? (my-map '(41) 1+) '(42))
    (check-equal? (my-map '(1 2 3 4) 1+) '(2 3 4 5))
    (check-equal? (my-map '(1 2 3 4 5) square) '(1 4 9 16 25))
    (check-equal? (my-map '(8 4 92 82 8 13) identity) '(8 4 92 82 8 13))
    (check-equal? (my-map '(8 4 92 82 8 13) 1+) '(9 5 93 83 9 14))))

(run-tests map-tests)
