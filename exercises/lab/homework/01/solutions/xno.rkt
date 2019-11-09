#lang racket

(provide winner
         play)

(require "matrix.rkt")
; You can use your matrix functions below, thanks to the "require" invocation above.

(define (id x) x)

; winner implementation that only detects draws right now.
; Put your own implementation here!
(define (winner b)
  (if (andmap (lambda (xs) (andmap id xs)) b)
      "D"
      #f))

; "Dumb" "AI", plays the "next" free spot, going left-to-right, top-to-bottom.
; Put your own implementation here!
(define (play curr-board curr-sign)
  (define (helper i j)
    (cond ((> i 2) #f)
          ((> j 2) (helper (+ i 1) 0))
          ((not (list-ref (list-ref curr-board i) j)) (cons i j))
          (else (helper i (+ j 1)))))
  (helper 0 0))
