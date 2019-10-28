#lang racket

; ****Function****al programming is called just that because a lot of the time
; you're manipulating not arguments but functions instead -
; composing different small functions acting on each other to get your end result
; instead of building one monolithic """simple""" loop

; to facilitate this every such language supports functions as first class values -
; just as you can pass other values you can just as easily pass functions as values
; and furthermore in the same way you can create and return other values from functions
; you can create and pass functions themselves

; let's see this in action
; passing in a function as an argument
; such a function is called a "higher-order" function
; A function that has two parameters - a function f and a value x
; and applies f to x twice
;
; EXAMPLES:
(define (1+ n) (+ 1 n))

; (apply-twice 1+ 2) -- 4
(define (apply-twice f x) (f (f x)))

; how about creating function values? Sure
; sure we can use a define, but very often functions we create
; are very specific and either don't have a good name or aren't worth exporting
; so we have a way to create "anonymous functions" - functions without a name,
; the same name we can write 5 to mean a number without a name

; the syntax for this is
; (lambda (args) body)
; very similar to
; (define (f args) body)
; in fact, this "function defining" define is syntactic sugar for the other define and a lambda!

; (define (apply-thrice f x) (f (f (f x))))
; is exactly the same thing as
; (define apply-thrice (lambda (f x) (f (f (f x)))))

; we can then use the functional value like any other function
; in fact above instead of writing a 1+ we could've done this:
; (apply-twice (lambda (x) (+ 1 x)) 2) -- 4

; to fill in the whole value puzzle, we can also return a function from a function
; here's an apply-twice that instead of taking two arguments, takes one argument
; and then returns a function expecting another - effectively taking two arguments again
; but the second one is "delayed"
; this is useful when we want to create "partially applied" functions to pass to other functions

; EXAMPLES:
; ((apply-twice-curried 1+) 2) -- 4 (notice the extra brackets)
(define (apply-twice-curried f)
  (lambda (x)
    (f (f x))))

; EXERCISE: const
; Generally useful function - return a function that always returns the first argument
; Useful when we want to replace all occurrences of an item with a fixed one.
; EXAMPLES:
; ((const 5) 10) -- 5
; ((const 0) 69) -- 0
; ((const 42) 80085) -- 42
(define (const x)
  (lambda (y) x))

; EXERCISE: add-n
; A function that takes a number n and returns a function that takes a number (m)
; and adds n to it.
; EXAMPLES:
; (define add-10 (add-n 10))
; (add-10 5) -- 15
; ((add-n 10) 13) -- 23
(define (add-n n)
  (lambda (m) (+ n m)))

; EXERCISE: compose
; Generally useful function - compose two functions
; i.e. first apply one and then the other
; EXAMPLES:
; ((compose 1+ 1+) 10) -- 12
; ((compose (lambda (x) (expt 2 x)) 1+) 9) -- 1024
; ((compose 1+ (lambda (x) (expt 2 x))) 9) -- 513
(define (compose f g)
  (lambda (x)
    (f (g x))))

; EXERCISE: iterate
; Let's apply a function n times. This is actually quite useful.
; EXAMPLES:
; (iterate 10 1+ 5) -- 15
(define (iterate n f x)
  (if (= n 0)
      x ; iterating a function 0 times is just the value itself
      (f (iterate (- n 1) f x))))

; EXERCISE: iterate-curried
; Let's create a *new* function which applies f n times to it's argument
; EXAMPLES:
; ((iterate-curried 10 1+) 5) -- 15
(define (iterate-curried n f)
  (lambda (x)
    (if (= n 0)
        x
        (f ((iterate-curried (- n 1) f) x)))))

; EXERCISE: my-plus-iterate
; Use iterate/iterate-curried to define addition, as we've done before
; HINT: It might help to first define it recursively, to see what operation you are iterating
; and what value you are iterating upon.
; EXAMPLES:
; (my-plus-iterate 13 56) -- 69
(define (my-plus-iterate x y) (iterate x 1+ y))

; EXERCISE: my-mult-iterate
; Use iterate/iterate-curried to define multiplication, as we've done before
; HINT: It might help to first define it recursively, to see what operation you are iterating
; and what value you are iterating upon. You will need a lambda/inner definition here.
; EXAMPLES:
; (my-mult-iterate 16 16) -- 256
(define (my-mult-iterate x y)
  (iterate x (lambda (z) (+ y z)) 0))

; EXERCISE: fixpoint?
; Define a function fixpoint? f n, which checks whether n is a fixpoint of f
; (in other words whether f n == n)
;
; EXAMPLES:
; (fixpoint? (const 10) 0) -- #f
; (fixpoint? (const 10) 10) -- #t
(define (fixpoint? f n)
  (= n (f n)))

; EXERCISE: fixpoint
; Define a function fixpoint f, which finds a fixpoint for f, if there is one
;
; (fixpoint (const 100)) -- 100
; (fixpoint (lambda (x) (if (< x 10) (+ 1 x) 11))) -- 11
(define (fixpoint f)
  (define (go n)
    (if (= (f n) n)
        n
        (go (+ n 1))))
  (go 0))

; EXERCISE: fold-interval
; we saw this function last time
(define (sum-interval x y)
  (if (> x y)
      0
      (+ x (sum-interval (+ 1 x) y))))

; but we can also write this one
(define (prod-interval x y)
  (if (> x y)
      1
      (* x (prod-interval (+ 1 x) y))))

; and by "write" I mean I copy-pasted it
; they are *that* similar!
; write a function that generalizes over them
; by getting a null value nv which to return in the base case
; and a function which to apply in the recursive case
; let's make it return a lambda straight away so we can reuse it for {sum,prod}-interval
; HINT: Again, the trick here is to find the "common" parts of the previous two definitions.
; You will need to return a lambda.
; EXAMPLE:
; (fold-interval + 5 20 25) -- 140
(define (fold-interval f nv a b)
  (if (> a b)
      nv
      (f a (fold-interval f nv (1+ a) b))))

; now use it to define the previous two we've already seen
(define (sum-interval-fold a b) (fold-interval + 0 a b))
(define (prod-interval-fold a b) (fold-interval * 1 a b))

; along with some new ones

; EXERCISE: max-val-interval-fold
; Using fold-interval find the largest value of a function in an interval
; HINT: use the max builtin and assume the functions we are given always return natural numbers
; EXAMPLES:
; (define (weird-fn x)
;   (if (even? x)
;       (* x x)
;       (+ 1 x)))
; (max-val-interval-fold weird-fn 5 10) -- 100
(define (max-val-interval-fold f a b)
  (define (select x y)
    (if (= (max (f x) (f y)) (f x))
        x
        y))
  (f (fold-interval select 0 a b)))

; Using fold-interval find whether all the numbers in an interval satisfy a predicate p?
; EXAMPLES:
; (define (>10? n) (> n 10))
; (all >10? 8 20) -- #f
; (all >10? 11 20) -- #t
(define (all p? a b)
  (fold-interval (lambda (x rec) (and (p? x) rec)) #t a b))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The part below is homework 00!
; Let's think about "repeated application of a function to a value"
; We will represent these as lambdas that take a function f and a value v
; and apply f to v some number of times (the number of f's)
; We can have a "zero times application" of a function to a value - that's just the value itself.
(define zero (lambda (f v) v))

; Here is the "one time application" and "two time application" for examples
(define one (lambda (f v) (f v)))
(define two (lambda (f v) (f (f v))))

; Let's now implement a function that takes a "n-times application" and returns a "n+1 times application"
(define (succ n)
  (lambda (f v) ; since we're returning another "application" we need to write a lambda accepting our f and v
    (f (n f v)))) ; to apply f n+1 times, we simply need to apply it n times, and then apply it once more

; Now using these tools implement the following
; Read the *IMPORTANT* below, after reading both from-num and to-num's comments
; but before implementing them

; EXERCISE: from-num
; Write a function that takes a number and then constructs the "n-times application"
; HINT: Use succ and zero.
; EXAMPLES:
; ((from-num 5) (lambda (x) (+ 1 x)) 7) -- 12
(define (from-num n) void)

; EXERCISE: to-num
; Write a function that takes the "n-times application" and returns the number n
; EXAMPLES:
; (to-num one) -- 1
; (to-num two) -- 2
; (to-num (succ (succ two))) -- 4
; (to-num (lambda (f v) (f (f (f v))))) -- 3
(define (to-num n) void)

; IMPORTANT:
; For all naturals n it should hold that
; (to-num (from-num n)) -- n
; And for all "n-time applications" that
; (from-num (to-num n)) -- n
; Wait a second.. if these are convertible between each other
; and we don't lose any information, doesn't that mean thay are interchangable?
; So you can use them instead of natural numbers. And to boot they only use lambdas
; In conclusion - you don't need natural numbers in your language if you have lambdas!

; More exercises

; EXERCISE:
; If they really are natural numbers we should be able to define addition and multiplication.
; We can think of these as
;  If I know how to apply f to v n times
;  and I also know how to apply f to v m times,
;  I ought to be able to know how to apply f to v (n + m) times
; Same with multiplication
; You are *not* allowed to use {from,to}-num here.

; EXERCISE: plus
; EXAMPLES:
; (to-num (plus (from-num 20) (from-num 10))) -- 30
; ((plus (from-num 20) (from-num 10)) (add-n 30) 69) -- 969
(define (plus n m) void)

; EXERCISE: mult
; EXAMPLES:
; (to-num (mult (from-num 10) (from-num 13))) -- 130
; (to-num (mult (succ (succ zero)) (succ (succ zero)))) -- 4
(define (mult n m) void)

; Difficult bonus, give up: pred
; Write a function that takes the "n-times application" and gives back the "n-1 times application")
; (without using {from,to}-num)
;
; EXAMPLES:
; (to-num (pred one)) -- 0
; (to-num (pred two)) -- 1
(define (pred n) void)
