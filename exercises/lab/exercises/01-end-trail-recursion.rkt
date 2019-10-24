#lang racket

; todays exercise is to show how FP languages can manage to not be useless

; it might be helpful to first read up on function calls and stack frames
; whenever you do a function call you need to allocate memory for local variables
; you also need to remember an additional address
; this all takes up memory, especially when you are not doing a constant amount
; of function calls
; in other words when you are doing recursion
; this also affects program speeds

; this is for example a recursive function, which would be way faster with a loop
; summing the numbers from a to b inclusive
(define (sum-interval a b)
  (if (> a b)
      0
      (+ a (sum-interval (+ 1 a) b))))

; there is a better way to do it though!
; and a way which allows us to run programs without leaking 10gbs of RAM
(define (sum-interval-iter a b)
  (define (help acc i)
    (if (> i b)
        acc
        (help (+ i acc) (+ i 1))))
  (help 0 a))
; here we defined an inner helper function, to "iterate" through the values in [a,b]
; how does this help?
; if you notice, in all the cases of help, the last operation is the recursive call
; in general recursion formulated in this way is called "tail recursion"
; (because the call is at the end/tail)
; *because* the last call is the recursive call, that means that
; we will certainly not need any more of the local variables (stack frame)
; that we have created in our current call
; therefore we can just reuse them for our next call
; this even saves us from having to save a new return address every time
; because it is also the same
; it is entirely equivalent to having a for-loop in an imperative program
; with the acc that we pass acting as an "accumulator variable"
; and i as our index

; every self-respecting FP language compiler does this optimisation for you

; to convince yourself that there is actually optimisation going on
; you can use the procedure time, which will show you how much time
; (actually three different times) the evaluation of something takes

;(time (sum-interval 1 10000000))
;(time (sum-interval-iter 1 10000000))
; Output:
;|| 15
;|| cpu time: 709 real time: 708 gc time: 376
;|| 50000005000000
;|| cpu time: 41 real time: 41 gc time: 0
;|| 50000005000000
; LEGEND:
; cpu time - time spent by the cpu on this computation
;            this include time spent by *all* cores
; real time - actual time that has passed
; gc time - how much of the time spent was spent doing garbage collection

; as you can see not only is the iter version faster in CPU time
; but more importantly it also has spent *almost no* (not noticeable)
; time in garbage collection - because it didn't have to allocate in deallocate variables
; this also means that if we used a huge number with the first one we would probably
; run out of RAM and bad things would happen

; EXERCISE: implement an iterative factorial
(define (fact-iter n)
  (define (help acc i)
    (if (= i 0)
        acc
        (help (* i acc) (- i 1))))
  (help 1 n))

; fibonacci - classic example of hugely ineffective recursive function
; EXERCISE:
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

; but do it iterative, by using an inner helper to hold and pass previous values
; it helps to think of an invariant here for our helper function
; the invariant that I will enforce is this:
; (indexing starts from 0)
; for (helper prev curr i)
; prev holds the i-1th fibonacci number
; curr holds the ith fibonacci number
; if I pass in (helper 0 1 1)
; and if I make sure my invariant continues to be true in the recursive case
; and I stop at i == n
; then in the end I will have the nth fibonacci number in curr
; EXERCISE:
(define (fib-iter n)
  (define (help prev curr i)
    (if (= i n)
        curr
        (help curr (+ prev curr) (+ i 1)))) ; at this point our i increments to i + 1,
                                            ; so we need to move our ith number to prev,
                                            ; and generate the i+1th number in curr
  (cond ((= n 0) 0) ; we need to specifically check for 0 and 1, so that we don't loop infinitely
        ((= n 1) 1)
        (else (help 0 1 1))))

; EXERCISE: count the digits of a number
; (digits-num 5) -- 1
; (digits-num 123) -- 3
; example in which you're not really gaining that much by writing an iterative version
(define (digits-num n)
  (if (< n 10)
      1
      (+ 1 (digits-num (quotient n 10)))))

; Exercise: reversing a number
; (reverse-num 0) -- 0
; (reverse-num 123) -- 321
; an example of a function that is actually easier to write with a helper
(define (reverse-num n)
  (define (helper acc curr)
    (if (< curr 10)
        (+ curr (* 10 acc))
        (helper (+ (remainder curr 10)
                   (* 10 acc))
                (quotient curr 10))))

  (helper 0 n))

; BONUS: recursive reverse-num
; showcase for let
(define (reverse-num-rec n)
  (if (< n 10)
      n
      (let ((rec (reverse-num-rec (quotient n 10)))
            (current (remainder n 10)))
        (+ (* current (expt 10 (digits-num rec)))
           rec))))

; EXERCISE: recursive ackermann
; for m and n natural numbers:
; ack(m, n) = n + 1                     if m == 0
; ack(m, n) = ack(m - 1, 1)             if m > 0 and n = 0
; ack(m, n) = ack(m - 1, ack(m, n - 1)) if m > 0 and n > 0
(define (ack m n)
  (cond ((= m 0) (+ n 1))
        ((= n 0) (ack (- m 1) 1))
        (else (ack (- m 1) (ack m (- n 1))))))

; EXERCISE: ackermann but iteratively
; but not really!
; this is an example of a function that is not primitive recursive
; intuitively the m argument is 
; "how deep our nesting of for loops is going to be"
; in other words in order to express (ack-iter 5 n)
; we will need to have five nested for loops
; this should hint towards the fact that you can't write this function
; using tail recursion, which was "intuitively equivalent" to a *single* for-loop
(define (ack-iter m n) void)
