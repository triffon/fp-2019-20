; this is a one line comment


; we need to specify this line, for some more complicated reasons
; than we are currently interested in
#lang racket

; explain about drracket vs my env
; I have no idea but we'll explain as we go
; TODO: show drracket, show setting a lang, show running

; talk about a REPL/interpreter

; this is a multiline comment, I will abuse these a bit, by moving them down the file

; TODO: talk about primitives and values and special forms
; everything is a value
; integers

; negative numbers

; fractional numbers

; floats

; strings

; bools


; even functions


; TODO: explain how the syntax works, show a very basic example
; function application - the first item in the list must be a function
; and the rest are it's arguments

; + and * are special - they take varying numbers of arguments



; even zero - because they form a monoid


; we can easily nest function calls by replacing one of the arguments
; with another function call (which is itself a value still)
; CONVENTION: we put multiple long arguments on new-lines, aligned to each other




; TODO: show define syntax for aliasing, say about side effects
; we can define names to bind them to some values


; we can even bind functions, as they are first-class



; we can define functions by specifying which arguments they take
; and then specifying their body
; TODO: define syntax for functions
; the syntax is (define (func-name arg0 arg1 arg2..) function-body)
; where function-body is a value
; the value (semantics) of calling (func-name arg0 arg1 arg2) is function-body

; a function that takes two arguments and calculates their sum
(define (sum-two x y) (+ x y))

; we have conditional statements in the form of an if-then-else clause
; which is again itself a value
; syntax - (if cond then-clause else-clause), where all three of
; cond, then-clause, else-clause are values, and cond is a boolean value

; if is a ternary special form, which is mostly self-explanatory
; it's a special form because it doesn't evaluate both branches (it would be worthless)
; (if cond-val true-val false-val)
; TODO: examples
;(if #t 10 5)
;(if #f (+ 20 50) 5)

; = is used to compare integers for equality
;(if (= 3 3) 4 5)

; TODO: explain example syntax
; TODO: do them exercises:

; (succ 0) -- 1
; (succ 42) -- 43
(define (succ n) void)

; (pred 70) -- 69
(define (pred n) void)

; you can use these below

; our favourite functions!

; Exercise: factorial
; fact(0) = 1
; fact(n) = n * fact(n - 1)

; (fact 0) -- 1
; (fact 5) -- 120
(define (fact n) void)

; Exercise: fibonacci
; fib(0) = 0
; fib(1) = 1
; fib(n) = fib(n - 1) + fib(n - 2)

; (fib 0) -- 0
; (fib 1) -- 1
; (fib 9) -- 34
; (fib 12) -- 144
(define (fib n) void)


; Exercise: addition
; Let's define our own addition and multiplication using succ and pred, as an exercise in syntax and recursion
; Only for natural numbers (so we don't deal with negative numbers).

(define (my-plus x y) void)
; HINT: Use the following (mathematical) definition:
; my-plus(x, y) = y                   if x == 0
; my-plus(x, y) = 1 + my-plus(x, y)   otherwise

; Exercise: multiplication
; Now for multiplication in the same style as my-plus, using my-plus as a building block

(define (my-mult x y) void)
; HINT: Definition:
; my-mult(x, y) = 0                   if x == 0
; my-mult(x, y) = y + my-mult(x, y)   otherwise

; Exercise: Fastpow
; fast-pow(x, y) = 1                        if y == 0
; fast-pow(x, y) = fast-pow(x * x, n)       if y == 2 * n
; fast-pow(x, y) = x * fast-pow(x * x, n)   if y == 2 * n + 1

; Use remainder and quotient
; try to guess what they do...
;(remainder 9 2)
;(quotient 9 2)
; surprised_pikachu.jpeg

(define (fast-pow x n) void)

; We can also nest definitions to use as helpers.
; They can be used in the scope in which they are defined
; (just as we defined stuff in the global scope, and used it in the global scope until now)
; EXAMPLE:

;(useless-function 10) -- 36
(define (useless-function x)
  (define y 5)
  (define (f z) (+ x z 1)) ; note how we can refer to x here, because our define is internal
  (+ x y (f x)))

; Exercise: Prime numbers
; To find out if a number is prime we just check all numbers between 2 and the number itself
; keeping track if any of them divide the number, using an if or an (&&)

; predicates (functions that return true/false) conventionally end in an ?
; Major hinting:
; Use two helpers - one which which checks if a number divides another,
; e.g.
; (divides? 10 5) -- #t
; (divides? 12 5) -- #f

; The second helper will be to "iterate" through all the number between 2 and n - 1
; checking if any of them divides our initial n (obviously if any do, then it's not prime)

; for this purpose we will "carry around" the current i we are checking
; so our second helper (our iterator) will be of this form
; (help 5) -- check if our n is divided by 5
;          -- n is in scope here and we can use it because we are defining our helper internally
(define (prime? n)

  (define (divides? x y) void)

  (define (help i) void)

  void)
