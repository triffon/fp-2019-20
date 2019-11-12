; TODO: TALK ABOUT HOMEWORK
; TODO: SECOND HOMEWORK
; TODO: SEPERATION

; #### Assoc lists

; EXERCISE: Keys
(define (keys kvs) void)

; EXAMPLES:
; (keys '((1 . 2) (3 . 5) (10 . 12))) ;-- '(1 3 10)

; EXERCISE: Values
(define (vals kvs) void)

; EXAMPLES:
; (vals '((1 . 2) (3 . 5) (10 . 12))) ;-- '(2 5 12)

; EXERCISE: Querying
(define (at k kvs) void)

; EXAMPLES:
; (at 10 '((13 . 14) (10 . 2))) ;-- 2
; (at 69 '((13 . 14) (10 . 2))) ;-- #f

; EXERCISE: Insertion
(define (insert k v kvs) void)

; EXAMPLES:
; (at 69 '((13 . 14) (10 . 2))) ;-- #f

; EXERCISE: Deletion
(define (delete k kvs) void)

; EXERCISE: Modification
; Return a tuple of the old value and the new map.
; If they key is not present pass a #f to the function and insert the result.
; If they function returns an #f treat that as deleting the element.

; These things combined make this function very general - you can express
; all the other ones above using it.

; Notably it won't work for booleans (but an assoc list of booleans is a set instead
; so it's not too big a loss)
(define (modify k f kvs) void)

; EXAMPLES:
; (define (f x) (+ 1 x))
; (modify 5 f '((5 . 10) (10 . 12))) ;-- '(10 . ((5 . 11) (10 . 12)))
; (define (g x) (if x (* 2 x) 1337))
; (modify 10 g '((10 . 12) (13 . 13))) ;-- '(12 . ((10 . 24) (13 . 13)))
; (modify 11 g '((10 . 12) (13 . 13))) ;-- '(#f . ((11 . 1337) (10 . 12) (13 . 13)))
; (define (h x) #f)
; (modify 10 h '((10 . 12) (13 . 13))) ;-- '(12 . ((13 . 13)))

; EXERCISE: Swap the elements of a 2-tuple
(define (swap tup) void)

; EXAMPLES:
; (swap '(1 . 2)) ;-- '(2 . 1)

; EXERCISE: Flipping a map
; use a combining function f for duplicates
; swap the keys and values, by using a combining function f for any resulting duplicate keys
(define (tumble-with f kvs) void)

; EXAMPLES:
; ; example without duplicates
; (tumble-with + '((1 . 2) (2 . 3) (5 . 10) (13 . 12)) ;-- '((2 . 1) (3 . 2) (10 . 5) (12 . 13))
; ; example with duplicates
; (tumble-with * '((33 . 2) (2 . 3) (5 . 10) (3 . 2)) ;-- '((2 . 99) (3 . 2) (10 . 5))

; HINT: Continually insert into an empty map, thinking about what to do if a key is already there.
; Maybe modify will be helpful?

; EXERCISE: "Composition"
; "compose" the two maps like a function
; in other words return a third map with keys from the first
; and values which are the values of the second
; by using the values of the first which match the keys of the second
; set notation (way simpler to read):
; { <x, z> | <x, y> <- kvs1, <y, z> <- kvs2 }
(define (compose-kvs kvs1 kvs2) void)

; EXAMPLES:
; (define kvs1 '((1 . 2) (3 . 5) (10 . 12)))
; (define kvs2 '((1 . 3) (5 . 69) (420 . 12) (12 . 13)))
; (combine kvs1 kvs2) ;-- '((3 . 69) (10 . 13))

; HINT:
; Use a cartesian product and some kind of filter.

; #### Misc. list tasks

; EXERCISE: Take with a predicate
; Continually take elements while a predicate holds for the elements you "take".
(define (take-while p xs) void)

; EXERCISE: Drop with a predicate
; Continually drop elements while a predicate holds for the elements you "take".
(define (drop-while p xs) void)

; EXERCISE: Insert into a sorted list
; Insert an element in it's "right" place into an already sorted list.
; so that the list is still sorted after the insertion.
(define (insert x xs) void)

; EXAMPLES:
; (insert 10 '(1 9 12)) ;-- '(1 9 10 12)

; EXERCISE: Insertion sort
; Sort a list by using the following:
; 0. The empty list is sorted.
; 1. Insert preserves "sortedness"
(define (insertion-sort xs) void)

; EXERCISE: Get the smallest element from a list
(define (minimum xs) void)

; EXAMPLES:
; (minimum '()) ;-- #f
; (minimum '(10 1300 9)) ;-- 9

; EXERCISE: Selection sort
; Sort a list by using the fact that if you always take the smallest element
; and cons it to the rest of the sorted list, you will get a sorted list.
(define (selection-sort xs) void)

; EXERCISE: Merge two sorted lists
(define (merge xs ys) void)

; EXAMPLES:
; (merge '(1 3 5) '(2 4 6 8)) ;-- '(1 2 3 4 5 6 8)

; EXERCISE: Merge sort
; Sort a list by using the fact that you can split it into two halves to sort
; and also that given two sorted lists, merge produces a sorted list.
; Be careful about your base case.
(define (merge-sort xs) void)

; EXERCISE: Partition
; Split the elements of a list into a tuple of those that satisfy p, and those that don't.
(define (partition p xs) void)

; EXAMPLES:
; (partition even? '(1 2 3 4 5 6)) ;-- '((2 4 6) . (1 3 5))
; (partition (lambda (x) (< x 10)) '(1 2 3 13 12 9)) ;-- '((1 2 3 9) . (13 12))

; EXERCISE: Quicksort
; Sort a list by using the fact that you can choose an element p (the head for example)
; of a list, and then seperate the list into two piles - the ones smaller than it, and the ones larger.
; Sorting those lists and then putting the p in the middle will result in a sorted list!
(define (quick-sort xs) void)
