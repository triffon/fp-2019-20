#lang racket

(define (succ x) (+ x 1))

(define (pred x) (- x 1))

(define (safe-div x)
  (if (even? x)
    (/ x 2)
    x))

(define (month-index m)
  (cond [(equal? m "January")    1]
        [(equal? m "February")   2]
        [(equal? m "March")      3]
        [(equal? m "April")      4]
        [(equal? m "May")        5]
        [(equal? m "June")       6]
        [(equal? m "July")       7]
        [(equal? m "August")     8]
        [(equal? m "September")  9]
        [(equal? m "October")   10]
        [(equal? m "November")  11]
        [(equal? m "December")  12]
        [else "Not a month!"]))

; x1 = 1
; x2 = -1/3
(define (is-root? x)
    (zero? (+ -1
              (* -2 x)
              (* 3 (expt x 2)))))

(define (factorial n)
  (if (= n 0) 1 (* n (factorial (- n 1)))))

(define (fibonacci n)
  (if (< n 2)
    n
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

(define (add x y)
  (if (= x 0)
    y
    (succ (add (pred x) y))))

(define (multiply x y)
  (cond [(= 0 x) 0]
        [(= 1 x) y]
        [else (add y(multiply (pred x) y))]))

