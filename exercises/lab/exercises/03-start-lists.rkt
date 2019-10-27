#lang racket

; L       L
;   I   I
;     S
;   T   T
; S       S

; TODO: talk about =, eq?, eqv?, equal?
; = - nums
; eq? - object (ptr) eq
; eqv? - same as eqv?, unless otherwise defined (otherwise defined for num and char)
; equal? - same as eqv?, unless otherwise defined - safest bet, usually what is used for
; complex datatypes

; TODO: tuples, cons(truct), car (head), cdr (tail)

; TODO: lists - cons + '()
; TODO: applications are actually lists

; TODO: quote eval
; TODO: examples about what quotes evaluate to, and equalities?
; TODO: example building an application by hand

; TODO: my-null? - fine to use eq? here, guaranteed by R5RS
; Check if a thing is the empty list
; EXAMPLES:
; (my-null? '()) -- #t
; (my-null? '(1)) -- #f
; (my-null? 5) -- #f - this is not a list at all
(define (my-null? xs) void)

; TODO: sum
; TODO: why xs?
; TODO: recursion talk
(define (sum xs) void)

; Some base functions for using lists

; EXERCISE: Length
; Calculate the length of a list
; EXAMPLES:
; (my-length '(1 2 3)) ; 3
; (my-length '()) ; 0
(define (my-length xs) void)

; EXERCISE: Take
; Take the first n elements of a list
; N.B. the builtin function actually errors out if n is larger than the length of the list
; EXAMPLES:
; (my-take 2 '()) -- '()
; (my-take 5 '(1 2 3)) -- '(1 2 3)
; (my-take 5 '(0 1 2 3 4 5)) -- '(0 1 2 3 4)
(define (my-take xs) void)

; EXERCISE: Drop
; Drop the first n elements of a list
; N.B. the builtin function actually errors out if n is larger than the length of the list
; EXAMPLES:
; (my-drop 2 '()) -- '()
; (my-drop 5 '(1 2 3)) -- '()
; (my-drop 4 '(0 1 2 3 4 5)) -- '(4 5)
(define (my-drop xs) void)

; EXERCISE: Index
; Take an element at a specific index (starting from 0)
; EXAMPLES:
; (ix '(1 2 3) 0) -- 1
; (ix '(1 2 3) 2) -- 3
; (ix '(1 2 3) 3) -- 'error
(define (ix xs n) void)

; EXERCISE: Sublist
; Get a sublist between two indices inclusive
; EXAMPLES:
; (sublist 3 5 '(0 1 2 3 4 5 6 7 8)) -- '(3 4 5)
; HINT:
; Use take and drop.
(define (sublist n m xs) void)

; EXERCISE: Product of a list
; Multiply all the numbers in a list
; EXAMPLES:
; (prod '(1 2 3)) -- 6
; (prod '(42 69)) -- 2898
; (prod '()) -- 1
; (because 1 is the neutral with regards to multiplication)
(define (prod xs) void)

; EXERCISE: Range of numbers
; Generate a list of the elements in the interval a b inclusive.
; EXAMPLES:
; (from-to 1 5) -- '(1 2 3 4 5)
; (from-to 6 5) -- '()
; (from-to 5 5) -- '(5)
(define (from-to a b) void)

; EXERCISE: Product of an interval
; Multiply the numbers in an interval, more composably now.
; EXAMPLES:
; (prod-interval 1 5) -- 120
; (prod-interval 6 5) -- 1
(define (prod-interval a b) void)

; EXERCISE: Factorial
; You know the drill - but use lists, and what we just defined
(define (fact n) void)

; EXERCISE: Append
; Append two lists together.
; N.B.: It is almost *never* necessary to recurse on two things at once.
; Think about which list you will need to recurse on.
; N.B.: The builtin append works with any number of lists!
; EXAMPLES:
; (my-append '(1 2 3) '(4 5)) -- '(1 2 3 4 5)
; (my-append '() '(4 5)) -- '(4 5)
; (my-append '(1 2 3) '()) -- '(1 2 3)
(define (my-append xs ys) void)

; EXERCISE: Annoying0
; Map each number in a list to its square
; EXAMPLES:
; (annoying0 '(1 2 3 4 5)) -- '(1 4 9 16 25)
(define (annoying0 xs) void)

; EXERCISE: Annoying1
; Map each number in a list to whether that number is prime.
; EXAMPLES:
; (annoying0 '(1 2 3 4 5)) -- '(#f #t #t #f #t)
(define (annoying1 xs) void)

; EXERCISE: map
; Wow gee those are basically the same thing - the only different thing is
; what function you're applying to each element. Abstract that away.
; Congratulations, now you can write 80% of all programs you want to write
; that operate on lists.
; EXAMPLES:
; (my-map (lambda (x) (+ 1 x)) '(1 2 3 4 5)) -- '(2 3 4 5 6)
; (my-map even? '(1 2 3 4 5 6)) -- '(#f #t #f #t #f #t)
(define (my-map f xs) void)

; EXERCISE: filter
; In the same vein, very often we want to leave only the elements of a list
; that satisfy a certain condition.
; EXAMPLES:
; (my-filter even? '(1 2 3 4 5 6)) -- '(2 4 6)
; (my-filter odd? '(1337 42)) -- '(1337)
(define (my-filter p? xs) void)

; EXERCISE: All
; Check if all elements of a list satisfy a predicate
; EXAMPLES:
; (all? even? '()) -- #t
; (all? even? '(2 4 6)) -- #t
; (all? even? '(2 3 4 6)) -- #f
(define (all? p? xs) void)

; EXERCISE: fold
; Looking back at everything - lenght, sum, prod, append, map, filter, all?, etc
; You can see the common pattern of recursion, with only these differing points:
; * When our list is empty we return some "default" value that is different in every case.
; * When our list isn't empty we take the head of a list and a recursive call on the tail
;   and afterwards we apply some function f to it.
; Let's abstract this away.
; NOTES: nv stands for null value.
; (now you can write 100% of programs you want to write using lists).
; EXAMPLES:
; (my-foldr + 0 (from-to 0 100)) -- 5050
; (my-foldr * 1 (from-to 1 5)) -- 120

; ; all? using foldr
; (my-foldr (lambda (x rec) (and (even? x) rec))
;           #t
;           '(2 4 6)) -- #t
; (my-foldr (lambda (x rec) (and (even? x) rec))
;           #t
;           '(2 4 6 7)) -- #f
(define (my-foldr f nv xs) void)

; EXERCISE: Redoing it.
; Reimplement length, sum, prod, all?, append, map, filter using my-foldr.

; EXERCISE: Redoing it v2
; Reimplement take and drop using foldr.

; EXERCISE: accumulate ~ foldr
; Referring to accumulate from lectures:
; Implement accumulate using foldr.
; And implement foldr using accumulate.
