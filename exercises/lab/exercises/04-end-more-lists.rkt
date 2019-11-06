#lang racket



;(define (sum-list* xs)
;  (if (null? xs)
;      0
;      (+ (car xs) (sum-list* (cdr xs)))))
;
;(define (1+ n) (+ 1 n))
;(define (2* x) (* 2 x))
;5                 ; (1+     (1+     (1+     (1+     (1+      0)))))
;(iterate* 2* 1 5) ; (2*     (2*     (2*     (2*     (2*      1)))))

;'(1 2 3 4 5)
;(foldr* (+) 0 '(1 2 3 4 5))
;  ; (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))
;  ; (+    1 (+    2 (+    3 (+    4 (+    5  0)))))
;
;(define (foldr* f nv xs)
;  (if (null? xs)
;      nv
;      (f (car xs) (foldr* f nv (cdr xs)))))
;
;(define (iterate* f nv n)
;  (if (= 0 n)
;      nv
;      (f (iterate* f nv (- n 1)))))
;
; MORE LISTS

; TODO: reminder foldr
; TODO: talk about how it replaces cons
; and it being a "recursion scheme"
; similarly to "iterate" for nats
(define (my-foldr f v xs)
  (if (null? xs)
      v
      (f (car xs) (my-foldr f v (cdr xs)))))

; TODO: sum using foldr
(define (sum xs)
  (foldr + 0 xs))
; no tail recursion?!?!?!

; TODO: write function and show it's hard to do with foldr
(define (minus-from n xs)
  (if (null? xs)
      n
      (minus-from (- n (car xs)) (cdr xs))))

(minus-from 23 '(1 2 3 4 5 6))

; TODO: another example of inconvenience
(define (divide-by n xs)
  (if (null? xs)
      n
      (divide-by (/ n (car xs)) (cdr xs))))

; TODO: also not efficient - no tail recursion
; TODO: example of efficient sum-iter
(define (sum-iter xs)
  (define (go acc remaining-list)
    (if (null? remaining-list)
        acc
        (go (+ acc (car remaining-list)) (cdr remaining-list))))
  (go 0 xs))

; TODO: show foldl
; and what it does to lists
(define (foldl f nv xs)
  (if (null? xs)
      nv
      (foldl f (f nv (car xs)) (cdr xs))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

;(foldl - 10000 (from-to 1 100))
;
;(foldl - 20 '(1 2 3 4 5))
;(foldl - (- 20 1) '(2 3 4 5))
;(foldl - ((- 20 1) 2) '(3 4 5))
;(foldl - (((- 20 1) 2) 3) '(4 5))
;(foldl - ((((- 20 1) 2) 3) 4) '(5))
;(foldl - (((((- 20 1) 2) 3) 4) 5) '())
;
;(- (- (- (- (- 20 1) 2) 3) 4) 5)
;(- 1 (- 2 (- 3 (- 4 (- 5 20)))))

;(foldr - 20 '(1 2 3 4 5))
;(foldr - 10000 (from-to 1 100))
; TODO: talk about monoidal operations
; and how they act the same with foldl

adjoint.fun/transfer/labs/

; EXERCISE: reimplement minus-from and divide-by with foldl
(define (minus-from-foldl n xs) void)

(define (divide-by-foldl n xs) void)

; EXERCISE: Reverse (naively using append, maybe foldr?)
; Reverse a list
(define (my-reverse xs) void)
; EXAMPLES:
; (my-reverse '()) ;-- '()
; (my-reverse '(1 2 3)) ;-- '(3 2 1)

; EXERCISE: Reverse iteratively!
; HINT: Use an accumulator!
(define (my-reverse-iter xs) void)

; EXAMPLES:
; (my-reverse-iter '()) ;-- '()
; (my-reverse-iter '(1 2 3)) ;-- '(3 2 1)

; EXERCISE: Reverse with foldl
; HINT: Define a helper flip function:
; which swaps the arguments of a function
; ((my-flip remainder) 3 7) ;-- 1
; ((my-flip -) 6 10) ;-- 4
(define (my-flip f) void)
(define (my-reverse-foldl xs) void)

; EXAMPLES:
; (my-reverse-foldl '()) ;-- '()
; (my-reverse-foldl '(1 2 3)) ;-- '(3 2 1)

; now we can easily define our minus-from with correct brackets
;(define (minus-from-foldl n xs) void)

; EXERCISE: "Zip" two lists together, pointwise
; From two lists pointwise make a list tuples!
; Look at the examples!
(define (zip xs ys) void)
; EXAMPLES:
; (zip '(1 2 3) '()) ;-- '()
; (zip '(1 2 3) '(4 5 6)) ;-- '((1 . 4) (2 . 5) (3 . 6))
; (zip '(1 2)   '(4 5 6 7 8)) ;-- '((1 . 4) (2 . 5))

; EXERCISE: Generalised zip
; Also get a "zipping function" instead of cons-ing elements together.
(define (zip-with f xs ys) void)
; EXAMPLES:
; (zip-with + '(1 1 1) '(2 3 4)) ;-- '(3 4 5)
; (zip-with * '(2 1) '(2 3 4)) ;-- '(4 3)

; EXERCISE: Concatenate lists
; Write a function that given a list of lists, "flattens" it to once level.
(define (concat xss) void)
; EXAMPLES:
; (concat '(())) ;-- '()
; (concat '((1 2 3) (4 5 6) (7 8 9))) ;-- '(1 2 3 4 5 6 7 8 9)
; (concat '((1) () (7 8 9))) ;-- '(1 7 8 9)

; ...wait, haven't I seen this pattern somewhere before??
; EXERCISE: Concat with foldr
(define (concat-foldr xss) void)

; ...but we can also do it with foldl, since append is associative!
; EXERCISE: Concat with foldl
(define (concat-foldl xss) void)

; EXERCISE: Cartesian product
; let's do a cartesian product, now that we've seen a zip
; zip was a pairwise way to combine lists, this is "each with each" way to combine lists
; i.e. for each x in xs we cons x with each y in ys
(define (cartesian xs ys) void)
; EXAMPLES:
; (cartesian '(1 2 3) '()) ;-- ()
; (cartesian '(1 2 3) '(4 5)) ;-- (((1 . 4) (2 . 4) (3 . 4)) ((1 . 5) (2 . 5) (3 . 5)))
; (cartesian '(1 2) '(4 5 6)) ;-- (((1 . 4) (2 . 4)) ((1 . 5) (2 . 5)) ((1 . 6) (2 . 6)))


; EXERCISE: flatten - "recursive concat"
; We want a function that "concats" arbitrarily nested lists

; HINT: Look at these three cases and think about how to make each of them
; into "a list of depth 1":
; 1) the empty list
; 2) a non-empty list
; 3) something that isn't a list
(define (flatten xss) void)
; EXAMPLES:
; (flatten '((1 2 3) 4 () ((5 (6)) 7) (((8))))) ;-- '(1 2 3 4 5 6 7 8)

; EXERCISE: Recursive reverse
; Reverse a list, but also reverse all lists that are elements of it.
; HINT: Use a similar case breakdown to the flatten function.
; Maybe this is actually another recursion scheme just like foldr/iterate :thinking:
(define (uber-reverse xs) void)
; EXAMPLES:
; (uber-reverse '((1 2 3) 4 () ((5 (6)) 7) (((8))))) ;-- '((((8))) (7 ((6) 5)) () 4 (3 2 1))
