#lang racket

; TODO: come to discord!!!!!!
; TODO: write to me on discord!!!!!!!
; TODO: give me github!!!!!!!!!
; TODO: give poll for when to do stuff - https://doodle.com/poll/kiqzmckr4sz4rkmz

; TODO: show let{,*,rec} and cond?

; TODO: recursion is "slow" etc
; TODO: explain stack????

; TODO: implement this
(define (sum-interval a b) void)

; TODO: also implement this:
(define (sum-interval-iter a b) void)

; TODO: show with time, 1 10000000 is big enough
; talk about cpu and gc time

; EXERCISE: implement a iterative factorial
(define (fact-iter n) void)

; fibonacci - classic example of hugely ineffective recursive function
; EXERCISE:
(define (fib n) void)

; but do it iterative, by using an inner helper to hold and pass previous values
; EXERCISE:
(define (fib-iter n) void)

; EXERCISE: count the digits of a number
; (digits-num 5) -- 1
; (digits-num 123) -- 3
(define (digits-num number) void)

; implement this however you like
; Exercise: reversing a number
; (reverse-num 0) -- 0
; (reverse-num 123) -- 321
(define (reverse-num number) void)

; EXERCISE: recursive ackermann
; ack(m, n) = n + 1                     if m == 0
; ack(m, n) = ack(m - 1, 1)             if m > 0 and n = 0
; ack(m, n) = ack(m - 1, ack(m, n - 1)) if m > 0 and n > 0
(define (ack m n) void)

; EXERCISE: ackermann but iteratively
(define (ack-iter m n) void)
