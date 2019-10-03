; this is a one line comment


; we need to specify this line, it's fine to ignore it
; it's there because racket has the idea of being an environment in which
; you can embed your own language easily (you can see examples of this on racket's homepage)
#lang racket

; everything has a value - we have:

; integers
5

; negative numbers
-3

; fractional numbers
1/4

; floats
3.14

; strings
"lol"

; bools
#t
#f

; even functions are values
+
; + is simply the value "something which when applied with return the sum of it's arguments"


; function application works like this: you write a list of of things between brackets
; now the semantics of this list is:
; 0. All of the space seperated things in the list are evaluated
; 1. The first item is applied to all the rest

(+ 3 5)
; 0. + is evaluated as discussed above, 3 is evaluated to itself, 5 to itself
; 1. + is applied to 3 and 5 resulting in the value 8

; + and * are special - they take varying numbers of arguments

; this will sum all the numbers
(+ 3 5 10 12)


; even zero arguments - because they form a monoid (this is a very universal we will encounter later)
; + with 0
(+)
; * with 1
(*)

; we can easily nest function calls by replacing one of the arguments
; with another function call (which is itself a value still)
; CONVENTION: we put multiple long arguments on new-lines, aligned to each other

(+
  (* 6 7)
  (* 1 69))

; 0. + is evaluated as discussed above, (* 6 7) is evaluated which results in
; 0.0. * is evaluated as discussed above, 6 is evaluated to 6, 7 to 7
; 0.1. * is applied to 6 and 7 resulting in 42
; 0. so (* 6 7) is evaluated to 42, in the same way (* 1 69) is evaluated to 69
; 1. + is applied to 42 and 69 resulting in 111

; we can define names to bind them to some values

; this is a "special form" - it is not evaluated by the default rule we discussed just now
; this is because a) it has no value b) it has a "side effect" of changing what a name means

; at this line the value of some-random-name is undefined
(define some-random-name 10)
; at this line the value of some-random-name is 10
some-random-name

; we can even bind functions, as they are first-class

(define my-add0 +)
; my-add0 is now a synonym for +
(my-add0 5 2)

; we can define functions by specifying which arguments they take
; and then specifying their body
; the syntax is (define (func-name arg0 arg1 arg2..) function-body)
; where function-body is a value
; the value (semantics) of (func-name arg0 arg1 arg2) is function-body

;(define (f x0 x1 .. xn) body)

; a function that takes two arguments and calculates their sum
; CONVENTION: Write the body of define on a newline unless it's extremely short
; in this case it would be on the same line, but I put it on a new one to illustrate the point
(define (my-add1 x y)
  (+ x y))

; we have conditional statements in the form of an if-then-else clause
; which is again itself a value
; this is a special form, because it doesn't simultaneously evaluate all it's arguments
; syntax - (if cond then-clause else-clause)
; semantics - evaluate cond, then if it's #t, then the result of the entire if is the value of then-clause
; else it's the value of else-clause

;(if cond then-clause else-cause)

(if #t 5 3)
(if #f 5 3)

; no error here, despite us writing gibberish, because we don't evaluate both arguments
(if #t 5 (my-add1 5 my-add1))

; = is used to compare integers for equality

(= 5 0)
(= 5 5)

(if (= 3 3) 4 5)

; TODO(GEORGI): adjoint.fun/transfer/labs
; https://github.com/triffon/fp-2019-20/exercises/lab/README.md
; godzbanebane@gmail.com

; Syntax for the commnets below:
; x -- y
; means that x should evaluate to y
; this is my own convention for showing you what the results of function calls should be

; (succ 0) -- 1
; (succ 42) -- 43
(define (succ n) (+ 1 n))

; (pred 70) -- 69
(define (pred n) (- n 1))

; you can use these below

; our favourite functions!

; Exercise: factorial
; fact(0) = 1
; fact(n) = n * fact(n - 1)

; (fact 0) -- 1
; (fact 5) -- 120
; notice the alignment on the if branches
(define (fact n)
  (if (= n 0)
      1
      (* n (fact (pred n)))))

; Exercise: fibonacci
; fib(0) = 0
; fib(1) = 1
; fib(n) = fib(n - 1) + fib(n - 2)

; (fib 0) -- 0
; (fib 1) -- 1
; (fib 9) -- 34
; (fib 12) -- 144
(define (fib n)
  (if (= n 0)
      0
      (if (= n 1)
          1
          (+ (fib (- n 1)) (fib (- n 2))))))

; Exercise: addition
; Let's define our own addition and multiplication using succ and pred, as an exercise in syntax and recursion
; Only for natural numbers (so we don't deal with negative numbers).

(define (my-plus x y)
  (if (= x 0)
      y
      (succ (my-plus (pred x) y))))
; HINT: Use the following ("mathematical") definition:
; my-plus(x, y) = y                       if x == 0
; my-plus(x, y) = succ(my-plus(pred(x), y)) otherwise

; Exercise: multiplication
; Now for multiplication in the same style as my-plus, using my-plus as a building block

(define (my-mult x y)
  (if (= x 0)
      0
      (my-plus y (my-mult (pred x) y))))
; HINT: Definition:
; my-mult(x, y) = 0                         if x == 0
; my-mult(x, y) = my-plus(y, my-mult(pred(x), y)) otherwise

; Exercise: Fastpow
; fast-pow(x, y) = 1                        if y == 0
; fast-pow(x, y) = fast-pow(x * x, n)       if y == 2 * n
; fast-pow(x, y) = x * fast-pow(x * x, n)   if y == 2 * n + 1

; Use remainder and quotient
; try to guess what they do...
(remainder 9 2)
(quotient 9 2)
; surprised_pikachu.jpeg

(define (fast-pow x n)
  (if (= n 0)
      1
      (if (= (remainder n 2) 0)
          (fast-pow (* x x) (quotient n 2))
          (* x (fast-pow (* x x) (quotient (pred n) 2))))))

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
; keeping track if any of them divide the number, using an if or an and

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
; (help 5)
; n is in scope for our helpers and we can use it because we are defining them
(define (prime? n)

  (define (divides? x y)
    (= (remainder x y) 0))

  (define (help i)
    (or (= i n)                   ; we've iterated through all the numbers and found they all don't divided n, so n is prime
        (and (not (divides? n i)) ; or we haven't meaning that we should check that i doesn't divide n and also continue checking
             (help (succ i)))))

  (help 2)) ; we start with 2, because 1 *should* divide our number, for it to be prime
