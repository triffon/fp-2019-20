#lang racket

; L       L
;   I   I
;     S
;   T   T
; S       S


; There are a number of different notions of equality in scheme.
; We will shortly be exploring lists, which will require us to look at them,
; as to not get confused
;
; 0. = - the thing we've used so far, it only works for numbers
; 1. eq? - "pointer equality" except for some things
;          it is also implementation dependent, so it's best to look at docs for this
;          in chez scheme (eq? 0.0 0.0) is #f, while in racket it's #t
; 2. eqv? - the same as eq?, except for a few values, as defined in the scheme standard
;           notably numbers, char's, '()
; 3. equal? - the same as eqv?, except for a lot of things
;             the most "complete" equality - it will return #t for the most values
;             it's expected to recurse down data structures (e.g. lists)
;             unlike the other ones. This is your "safest" bet usually, and we aren't chasing performance

; Let's now talk about quote/eval
; quote (or ') is a special form that "delays execution"
; usually every expression is evaluated with the evaluation rule
; so (+ 1 2) evaluates to 3
; but if we quote it it will instead evaluate to (+ 1 2) itself
; so '(+ 1 2) evaluates to (+ 1 2)

; eval is the opposite of quote - it forces something to evaluate
; eval *IS NOT* a special form, and therefore its arguments are first evaluated once
; before being passed to eval
; so (eval 2) will evaluate to 2, because 2 evaluates to 2
; correspondingly
; (eval '(+ 1 2)) will evaluate to 3, because '(+ 1 2) evaluates to (+ 1 2)
; which eval will then evaluate once more to 3
; (eval ''a) will evaluate to the symbol a, because ''a evaluates once to 'a
; before being passed to eval, and then 'a evaluates to a

; having said that:
; a 2-tuple is something of this form: (a . b)
; e.g. here's a 2-tuple of 1 and 2
; '(1 . 2)
; we can use the function cons to construct one
; so we can also write the same 2-tuple as (cons 1 2)

; to use 2-tuples we have to functions:
; car - take the first element of a 2-tuple
; cdr - take the second element of a 2-tuple

; now that we have 2-tuples we can define lists:
; 0. '() is a list
; 1. for any a and any b, if b is a list, then (cons a b) is also a list

; as can be seen our lists are "right-nested" 2-tuples
; whose "last" element is always '()
; we can now reuse our car and cdr functions to mean
; car - take the "first" element of a list (its "head")
; cdr - take the "rest" elements of the list (its "tail")

; scheme will "prettify" your lists by writing them "flattened" and without
; the empty list at the end
; so (cons 1 (cons 2 (cons 3 '())))
; which would be (1 . (2 . (3 . '())))
; will be displayed as
; (1 2 3)
; equivalently we can also write '(1 2 3) instead of (cons 1 (cons 2 (cons 3)))

; you might have noticed now that this (1 2 3) business seems awfully familiar
; to the programs we've been writing - just like we can have the list '(+ 1 2)
; that's because that's exactly what our programs are - lists
; this is also where LISP gets its name from LIS(t)P(rocessor)
; going by the same logic we can manipulate our programs by writing quoted things
; and then eval-ing them,
; EXAMPLES:
; we can build an application by hand:
; > (eval (cons '+ (cons 1 (cons 2 '()))))
; 3

; if we have some summation (+ a b ...)
; we can instead make it into a multiplication by dropping the first element
; and cons-ing a * instead:
; > (define (change l) (eval (cons '* (cdr l))))
; > (change '(+ 1 2 3 4 5))
; 120

; today we will be focusing on lists though

; Check if a thing is the empty list
; It's fine to use eq? here, because the R5RS standard
; guarantees that (eq? '() '()) returns #t
; EXAMPLES:
; (my-null? '()) ;-- #t
; (my-null? '(1)) ;-- #f
; (my-null? 5) ;-- #f - this is not a list at all
(define (my-null? xs)
  (eq? '() xs))

; Summing a list
; We call our lists "xs", because of the following rationale:
; One dog, many dog*s*
; One x, many x*s*
; The same way our recursive functions on natural numbers
; all followed the recursive pattern of a special case for 0
; and a recursive case
; our recursive functions on lists will follow the pattern of
; a special case for '()
; and a recursive call for when we have a non-empty list
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs)
         (sum (cdr xs)))))

; EXERCISE: Length
; Calculate the length of a list
(define (my-length xs)
  (if (null? xs)
      0
      (+ 1 (my-length (cdr xs)))))
; EXAMPLES:
; (my-length '(1 2 3)) ;-- 3
; (my-length '()) ;-- 0

; EXERCISE: Take
; Take the first n elements of a list
; N.B. the builtin function actually errors out if n is larger than the length of the list
(define (my-take n xs)
  (if (or (= n 0) (null? xs))
      '()
      (cons (car xs) (my-take (- n 1) (cdr xs)))))
; EXAMPLES:
; (my-take 2 '()) ;-- '()
; (my-take 5 '(1 2 3)) ;-- '(1 2 3)
; (my-take 5 '(0 1 2 3 4 5)) ;-- '(0 1 2 3 4)

; EXERCISE: Drop
; Drop the first n elements of a list
; N.B. the builtin function actually errors out if n is larger than the length of the list
(define (my-drop n xs)
  (cond ((null? xs) '())
        ((= n 0) xs)
        (else (my-drop (- n 1) (cdr xs)))))
; EXAMPLES:
; (my-drop 2 '()) ;-- '()
; (my-drop 5 '(1 2 3)) ;-- '()
; (my-drop 4 '(0 1 2 3 4 5)) ;-- '(4 5)

; EXERCISE: Index
; Take an element at a specific index (starting from 0)
(define (ix xs n)
  (cond ((null? xs) 'error)
        ((= n 0) (car xs))
        (else (ix (cdr xs) (- n 1)))))
; EXAMPLES:
; (ix '(1 2 3) 0) ;-- 1
; (ix '(1 2 3) 2) ;-- 3
; (ix '(1 2 3) 3) ;-- 'error

; EXERCISE: Sublist
; Get a sublist between two indices inclusive
(define (sublist n m xs)
  (my-take (+ 1 (- m n)) (my-drop n xs)))
; EXAMPLES:
; (sublist 2 10 '(1 2 3)) ;-- '(3)
; (sublist 3 5 '(0 1 2 3 4 5 6 7 8)) ;-- '(3 4 5)
; HINT:
; Use take and drop.

; EXERCISE: Product of a list
; Multiply all the numbers in a list
(define (prod xs)
  (if (null? xs)
      1
      (* (car xs) (prod (cdr xs)))))
; EXAMPLES:
; (prod '(1 2 3)) ;-- 6
; (prod '(42 69)) ;-- 2898
; (prod '()) ;-- 1
; (because 1 is neutral with regards to multiplication)

; EXERCISE: Range of numbers
; Generate a list of the elements in the interval a b inclusive.
(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))
; EXAMPLES:
; (from-to 1 5) ;-- '(1 2 3 4 5)
; (from-to 6 5) ;-- '()
; (from-to 5 5) ;-- '(5)


; EXERCISE: Product of an interval
; Multiply the numbers in an interval, using what we've defined so far
(define (prod-interval a b) (prod (from-to a b)))
; EXAMPLES:
; (prod-interval 1 5) ;-- 120
; (prod-interval 6 5) ;-- 1

; EXERCISE: Factorial
; You know the drill - but use lists, and what we just defined
(define (fact n) (prod-interval 1 n))

; EXERCISE: Append
; Append two lists together.
; N.B.: It is almost *never* necessary to recurse on two things at once.
; Think about which list you will need to recurse on.
; N.B.: The builtin append works with any number of lists!

; Since we can attach elements "in front" of a list, but not at the back
; we will recurse on the first list and attach them to the front of the second
; (otherwise we will have to somehow attach elements at the back of our first list)
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))
; EXAMPLES:
; (my-append '(1 2 3) '(4 5)) ;-- '(1 2 3 4 5)
; (my-append '() '(4 5)) ;-- '(4 5)
; (my-append '(1 2 3) '()) ;-- '(1 2 3)

; EXERCISE: Annoying0
; Map each number in a list to its square
(define (annoying0 xs)
  (define (f x) (* x x))

  (if (null? xs)
      '()
      (cons (f (car xs)) (annoying0 (cdr xs)))))
; EXAMPLES:
; (annoying0 '(1 2 3 4 5)) ;-- '(1 4 9 16 25)


; EXERCISE: Annoying1
; Map each number in a list to whether that number is even.
(define (annoying1 xs)
  (if (null? xs)
      '()
      (cons (even? (car xs)) (annoying1 (cdr xs)))))
; EXAMPLES:
; (annoying1 '(1 2 3 4 5)) ;-- '(#f #t #f #t #f)

; EXERCISE: map
; Wow gee those are basically the same thing - the only different thing is
; what function you're applying to each element. Abstract that away.
; Congratulations, now you can write 80% of all programs you want to write
; that operate on lists.
(define (my-map f xs)
  (if (null? xs)
      '()
      (cons (f (car xs))
            (my-map f (cdr xs)))))
; EXAMPLES:
; (my-map (lambda (x) (+ 1 x)) '(1 2 3 4 5)) ;-- '(2 3 4 5 6)
; (my-map even? '(1 2 3 4 5 6)) ;-- '(#f #t #f #t #f #t)

; EXERCISE: filter
; In the same vein, very often we want to leave only the elements of a list
; that satisfy a certain condition.
(define (my-filter p? xs)
  (if (null? xs)
      '()
      (if (p? (car xs))
          (cons (car xs) (my-filter p? (cdr xs)))
          (my-filter p? (cdr xs)))))
; EXAMPLES:
; (my-filter even? '(1 2 3 4 5 6)) ;-- '(2 4 6)
; (my-filter odd? '(1337 42)) ;-- '(1337)

; Operate on functions instead, avoid a bit of code duplication
; We decide whether we "want to cons a x onto something"
; or we "want to do nothing to the something"

; N.B.: We would usually use
; (define (id x) x)
; instead here, but this way it's easier to understand, I think
(define (my-filter-cool p? xs)
  (if (null? xs)
      '()
      ((if (p? (car xs))
           (lambda (res) (cons (car xs) res))
           (lambda (res)                res))
       (my-filter-cool p? (cdr xs)))))
; EXAMPLES:
; (my-filter-cool even? '(1 2 3 4 5 6)) ;-- '(2 4 6)
; (my-filter-cool odd? '(1337 42)) ;-- '(1337)

; EXERCISE: All
; Check if all elements of a list satisfy a predicate
(define (all? p? xs)
  (if (null? xs)
      #t
      (and (p? (car xs)) (all? p? (cdr xs)))))
; EXAMPLES:
; (all? even? '()) ;-- #t
; (all? even? '(2 4 6)) ;-- #t
; (all? even? '(2 3 4 6)) ;-- #f

; EXERCISE: fold
; Looking back at everything - lenght, sum, prod, append, map, filter, all?, etc
; You can see the common pattern of recursion, with only these differing points:
; * When our list is empty we return some "default" value that is different in every case.
; * When our list isn't empty we take the head of a list and a recursive call on the tail
;   and afterwards we apply some function f to it.
; Let's abstract this away.
; NOTES: nv stands for null value.
; (now you can write 100% of programs you want to write using lists).
(define (my-foldr f nv xs)
  (if (null? xs)
      nv
      (f (car xs)
         (my-foldr f nv (cdr xs)))))
; EXAMPLES:
; (my-foldr + 0 (from-to 0 100)) ;-- 5050
; (my-foldr * 1 (from-to 1 5)) ;-- 120

; ; all? using foldr
; (my-foldr (lambda (x rec) (and (even? x) rec))
;           #t
;           '(2 4 6)) ;-- #t
; (my-foldr (lambda (x rec) (and (even? x) rec))
;           #t
;           '(2 4 6 7)) ;-- #f

; PROTIP:
; When wriitng a lambda for foldr name your arguments "x" and "rec"(ursive)
; to remind yourself that you are applying the current element ("x") to the
; "rec"-ursive call of the function

; EXERCISE: Redoing it.
; Reimplement length, sum, prod, all?, append, map, filter using my-foldr.

(define (length-foldr xs)
  (my-foldr (lambda (x rec) (+ 1 rec)) 0 xs))

(define (sum-foldr xs)
  (my-foldr + 0 xs))

(define (prod-foldr xs)
  (my-foldr * 1 xs))

(define (all?-foldr p? xs)
  (my-foldr (lambda (x rec) (and (p? x) rec)) #t xs))

; more cleanly
(define (and-fn x y) (and x y))
(define (all?-foldr-cleaner p? xs)
  (my-foldr and-fn #t (map p? xs)))

(define (append-foldr xs ys)
  (my-foldr cons ys xs))

(define (map-foldr f xs)
  (my-foldr (lambda (x rec) (cons (f x) rec))
            '()
            xs))

(define (filter-foldr p? xs)
  (my-foldr (lambda (x rec)
              (if (p? x)
                  (cons x rec)
                  rec))
            '()
            xs))

; EXERCISE: accumulate ~ foldr
; Referring to accumulate from lectures:
; Implement accumulate using foldr.
; And implement foldr using accumulate.

; I was too lazy to do this - if you actually care
; ask me and we can work it out together
; It will involve samo from-to-ing
