#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 3
; Подобно на задача 2, направете функции `(my-sin m x)` и `(my-cos m x)`,
; които изчисляват `m`-тите частични суми на `sin(x)` и `cos(x)`.

(define (my-sin m x)
  void)

(define (my-cos m x)
  void)

(run-tests (test-suite "tests"
             (test-suite "my-sin tests"
               (check-= (my-sin 15 1) (sin 1) 0.0001)
               (check-= (my-sin 15 2) (sin 2) 0.0001)
               (check-= (my-sin 15 6) (sin 6) 0.0001))
             (test-suite "my-cos tests"
               (check-= (my-cos 15 1) (cos 1) 0.0001)
               (check-= (my-cos 15 2) (cos 2) 0.0001)
               (check-= (my-cos 15 6) (cos 6) 0.0001)))
           'verbose)

