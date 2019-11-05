#lang racket

; take xs n
(define (take xs n)
  (if (zero? n)
    '()
    (cons (car xs)
          (take (cdr xs) (- n 1)))))

; drop xs n
(define (drop xs n)
  (if (zero? n)
    xs
    (drop (cdr xs) (- n 1))))

; transpose m
(define (transpose m) (apply map list m))

; prefix? xs ys
(define (prefix? xs ys)
  (if (> (length xs) (length ys))
    #f
    (equal? (take ys (length xs)) xs)))

; suffux? xs ys
(define (suffux? xs ys)
  (if (> (length xs) (length ys))
    #f
    (equal? (drop ys (length xs)) xs)))

; better-than-average xs
(define (average xs) (/ (apply + xs) (length xs)))

(define (better-than-average xs)
  (filter (lambda (x)
            (> x (average xs)))
          xs))

; middle-digits n
(define (num-to-list n)
  (define (helper n)
    (if (zero? n)
      '()
      (cons
        (remainder n 10)
        (helper (quotient n 10)))))
  (reverse (helper n)))

(define (middle-digits n)
  (let ((digits (num-to-list n)))
    (if (odd? n)
      #f
      (take (drop (num-to-list n)
                  (- (/ (length digits) 2) 1))
            2))))

; check-matrix m k
(define (only-divisors? xs k)
  (foldl (lambda (x acc)
           (and acc
                (zero? (remainder x k))))
         #t
         xs))

(define (check-matrix? m k)
  (not (foldl
         (lambda (row acc)
           (or acc
               (only-divisors? row k)))
         #f
         m)))

; max-unique xs
(define (unique? x xs)
  (= (foldl
       (lambda (y acc)
         (if (= x y) (+ acc 1) acc))
       0
       xs)
     1))

(define (flat-unique xss)
    (apply
      append
      (map (lambda (l) (filter (lambda (x) (unique? x l)) l)) xss)))

(define (max-unique xss)
  (if (null? (flat-unique xss))
    #f
    (apply max (flat-unique xss))))

