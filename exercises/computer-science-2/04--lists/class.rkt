#lang racket
(define (id x) x)

(define (accumulate operation null-value a b term next)
  (if (> a b)
      null-value
      (operation (term a) (accumulate operation
                                      null-value
                                      (next a)
                                      b
                                      term
                                      next))))

(define (accumulate-i operation null-value a b term next)
  (if (> a b)
      null-value
      (accumulate-i operation
                    (operation null-value (term a))
                    (next a)
                    b
                    term
                    next)))

(define (1+ n) (+ 1 n))
(define (exists? pred? a b)
  (accumulate (lambda (x y) (or x y))
              #f a b pred? 1+))

(define (forall? pred? a b)
  (not (exists? (lambda (k) (not (pred? k))) a b)))

(define (prime? n)
  (and (> n 1)
       (not (exists? (lambda (k) (= (remainder n k) 0))
                     2
                     (sqrt n)))))
  

;'(1 2 3)
;(cons 2 (cons 4 (cons 5 '())))
;(list 1 2 3 4 5)


(define l1 '(1 2 3 4 5 6 7 8))

(define (length L)
  (if (null? L)
      0
      (+ 1 (length (cdr L)))))

(define l2 '((1 2) (3 4)))

(define (sum L)
  (if (null? L)
      0
      (+ (car L) (sum (cdr L)))))


(define (product L)
  (if (null? L)
      1
      (* (car L) (product (cdr L)))))

(define (last L)
  (if (null? L)
      (error "No last element")
      (if (null? (cdr L))
          (car L)
          (last (cdr L)))))

(define (append L M)
  (if (null? L)
      M
      (cons (car L) (append (cdr L) M))))

(define (map f L)
  (if (null? L)
      '()
      (cons (f (car L)) (map f (cdr L)))))
  

(define (filter pred? L)
  (if (null? L)
      L
      (if (pred? (car L))
          (cons (car L) (filter pred? (cdr L)))
          (filter pred? (cdr L)))))

(define (divides? x y)
  (= (remainder y x) 0))

(define (prime? n)
  (if (< n 2)
      #f
      ; Дефинираме променлива rootn = √n
      (let ((rootn (sqrt n)))
        ; `i` пробягва от 0 до √n
        (define (for i)
          (if (> i rootn)
              #t
              (if (divides? i n)
                  #f
                  (for (+ 1 i)))))
        (for 2))))


(define (scp L)
  (sum (map (lambda (x) (expt x 3))
            (filter prime? L))))




