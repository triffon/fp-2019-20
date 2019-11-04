#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да направим списък от всички стойности в даден такъв.
; Искаме нивата на влагане да изчезнат.

(define (flatten xs)
  (void)
)

(define tests
  (test-suite "Flatten"
    (check-equal? (flatten '(1 3 ("wow" ("nesting") ("overload" 38 91)))) '(1 3 "wow" "nesting" "overload" 38 91))
    (check-equal? (flatten '(1 2 3)) '(1 2 3))
    (check-equal? (flatten '(((3)))) '(3))
  )
)

(run-tests tests 'verbose)
