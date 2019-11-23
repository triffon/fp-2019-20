#lang racket
; head, tail
; eq?, eqv?, equal?
(define (null? L)
  (eq? L '()))

; list?
(define (list?-1 x)
  (if (null? x)
      #t
      (if (pair? x)
          (list? (cdr x))
          #f)))

(define (list? x)
  (or (null? x)
      (and (pair? x)
           (list? (cdr x)))))


; length
(define (length L)
  (if (null? L)
      0
      (+ 1 (length (cdr L)))))
; map
(define (map f L)
  (if (null? L)
      L
      (cons (f (car L)) (map f (cdr L)))))


(define (map* f L)
  (foldr (lambda (x rec)
           (cons (f x) rec))
         '()
         L))

; filter
(define (filter p? L)
  (if (null? L)
      L
      (if (p? (car L))
          (cons (car L) (filter p? (cdr L)))
          (filter p? (cdr L)))))

(define (filter* p? L)
  (foldr (lambda (x rec)
           (if (p? x)
               (cons x rec)
               rec))
         '() L))
; append
(define (append L M)
  (if (null? L)
      M
      (cons (car L) (append (cdr L) M))))

(define (append* L M)
  (foldr cons
         '()
         L))

; foldr
(define (foldr op nv L)
  (if (null? L)
      nv
      (op (car L) (foldr op nv (cdr L)))))

; чрез foldr
; length
(define (sum L)
  (foldr + 0 L))
(define (1+ n) (+ 1 n))

(define (length* L)
  (foldr (lambda (x rec)
           (+ 1 rec))
         0
         L))
; map

(define (flip f)
  (lambda (x y)
    (f y x)))
; filter
; append

; foldl
(define (foldl op v L)
  (if (null? L)
      v
      (foldl op (op v (car L)) (cdr L))))


(define (foldl** op v L)
  (if (null? L)
      v
      (foldl op (op (car L) v) (cdr L))))





(define (foldl* op nv L)
  (define (help curr-L result)
    (if (null? curr-L)
        result
        (help (cdr curr-L) (op result (car curr-L)))))
  (help L nv))

(define (rcons x y)
  (cons y x))

(define rcons* (flip cons))

(define (snoc x y)
  (append y (list x)))

(define push-back snoc)

(define (reverse L)
  (foldr snoc '() L))


(define (reverse* L)
  (foldl (lambda (acc x)
           (cons x acc))
         '()
         L))

; foldl в Racket

; minus-from

(define (minus-from n L)
  (- n (foldr + 0 L)))


(define (minus-from* n L)
  (foldr (flip -) n L))



; reverse 3

; any?
(define (any? p? L)
  (if (null? L)
      #f
      (or (p? (car L))
          (any? p? (cdr L)))))

(define (any?* p? L)
  (foldl (lambda (x rec)
           (or rec x))
         #f
         L))
; all?
(define (all? p? L)
  (foldr (lambda (x rec)
           (and rec x))
         #t
         L))
; member?
(define (member? x L)
  (any? (lambda (y)
          (equal? y x))
        L))

; remove
(define (remove-all x L)
  (filter (lambda (y) (not (equal? x y))) L))

; count-occurences
(define (count-occurences x L)
  (length (filter (lambda (y) (equal? x y)) L)))

;;;;;;;;;;;;;

; take
(define (take n L)
  (define (help counter curr-L result)
    (if (> counter n)
        result
        (help (+ 1 counter)
              (cdr curr-L)
              (snoc (car curr-L) result))))
  (help 1 L '()))

(define (take* n L)
  (if (or (null? L) (= n 0))
      '()
      (cons (car L) (take (- n 1) (cdr L)))))

(define (take** n L)
  (foldl (lambda (acc x)
           (if (< (length acc) n)
               (snoc x acc)
               acc))
         '()
         L))
          
; drop


; foldr1
; foldl1
; maximum
 
; selection-sort
; slice
; zip
; zip-with

; unique
; set operations

; chunk

;;;;;;;;;;;;;

; atom?
; count-atoms
; flatten
; deep-reverse
; 
; deep-foldr
; deep-foldl
; 
; var-func
