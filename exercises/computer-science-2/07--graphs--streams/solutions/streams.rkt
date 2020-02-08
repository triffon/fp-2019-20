#lang racket
;;; Допускаме, че боравим с безкрайни потоци.
;;; Така можем да си пишем бездънни рекурсии.

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t)
     (cons h (delay t)))))

(define (first n s)
  (if (= n 0)
      '()
      (cons (head s) (first (- n 1) (tail s)))))

(define (from n)
  (cons-stream n (from (+ n 1))))

(define head car)
(define (tail xs)
  (force (cdr xs)))

(define (map-stream f xs)
  (cons-stream (f (head xs))
               (map-stream f (tail xs))))


(define (filter-stream p? xs)
  (if (p? (head xs))
      (cons-stream (head xs)
                   (filter-stream p? (tail xs)))
      (filter-stream p? (tail xs))))

(define (zip-streams-with op xs ys)
  (cons-stream (op (head xs) (head ys))
               (zip-streams-with op (tail xs) (tail ys))))

(define (add-streams xs ys)
  (zip-streams-with + xs ys))

;; 1 - ones
(define ones (cons-stream 1 ones))

;; 2 - nats
(define nats* (from 0))

; -- друго решение
(define nats (cons-stream 0
                          (add-streams ones nats)))

;; 3 - from
(define (from* n)
  (cons-stream n (from* (+ n 1))))
;; 4 - fibs
(define (fib n)
  (if (or (= n 0) (= n 1))
      n
      (+ (fib (- n 1) (- n 2)))))

(define fibs* (map-stream fib nats))

; -- друго решение
(define fibs
  (cons-stream 0 (cons-stream 1 (add-streams fibs
                                             (tail fibs)))))

;; 5 - primes
(define (divides? x y)
  (= 0 (remainder y x)))

(define (sieve xs)
  (let ((x (head xs)))
    (cons-stream (head xs)
                 (sieve (filter-stream (lambda (y)
                                         (not (divides? x y)))
                                       (tail xs))))))

(define primes (sieve (from 2)))

;; 6 - pythagoren-triples
(define (1+ n) (+ n 1))

; списък от числата между a и b
(define (between a b)
  (if (> a b)
      '()
      (cons a (between (1+ a) b))))

; списък от наредени двойки (n,m), за които n <= m и n,m са между a, b
(define (pairs-between a b)
  (if (> a b)
      '()
      (append (map (lambda (m) (cons a m))
                   (between a b))
              (pairs-between (1+ a) b))))

(define (sq x) (* x x))
(define (car#f xs)
  (if (null? xs)
      #f
      (car xs)))

; намира първата наредена двойка от естествени числа (a,b), за която a^2 + b^2 = c^2
; ако няма такава, връща #f
(define (find-first-pair c)
  (car#f (filter (lambda (p)
                   (let ((a (car p))
                         (b (cdr p)))
                     (= (+ (sq a) (sq b))
                        (sq c))))
                 (pairs-between 1 (- c 1)))))

(define pythagorean-triples
  ; премахва #f
  (filter-stream (lambda (q) q)
                 ; на всяко естествено число c съпоставя тройка (a,b,c),
                 ; за която a^2 + b^2 = c^2. Ако няма такава, слага #f.
                 (map-stream (lambda (c)
                               (let ((q (find-first-pair c)))
                                 (if q
                                     (list (car q) (cdr q) c)
                                     #f)))
                             nats)))
