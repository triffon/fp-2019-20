(define l (list 1 2 3 4 5 6 7 8 9 10))

(define (list? l)
  (or (null? l) (and (pair? l) (list? (cdr l)))))

(define (list? l)
  (if (null? l) #t
      (and (pair? l) (list? (cdr l)))))

(define (length l)
  (if (null? l) 0
      (+ 1 (length (cdr l)))))

(define (length l)
  (foldr (lambda (x r) (+ 1 r)) 0 l))

(define (list-ref l n) (car (list-tail l n)))

(define (list-tail l n)
  (if (= n 0) l
      (list-tail (cdr l) (- n 1))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0) x
        (f ((repeated f (- n 1)) x)))))

(define (list-tail l n)
  ((repeated cdr n) l))

(define (memberg equality)
  (lambda (x l)
    (cond ((null? l) #f)
          ((equality (car l) x) l)
          (else (member x (cdr l))))))

(define member (memberg equal?))
(define memv (memberg eqv?))
(define memq (memberg eq?))

(define (from-to a b)
  (if (> a b) '()
      (cons a (from-to (+ a 1) b))))

(define (collect a b next)
  (if (> a b) '()
      (cons a (collect (next a) b next))))

(define (1+ x) (+ x 1))

(define (from-to a b) (collect a b 1+))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (append l1 l2)
  (if (null? l1) l2
      (cons (car l1) (append (cdr l1) l2))))

(define (append l1 l2)
  (foldr cons l2 l1))

(define (snoc x l) (append l (list x)))

(define (reverse l)
  (if (null? l) l
      (snoc (car l) (reverse (cdr l)))))

(define (reverse l)
  (define (iter m r)
    (if (null? m) r
        (iter (cdr m) (cons (car m) r))))
  (iter l '()))

(define (reverse l)
  (foldr snoc '() l))

(define (rcons l x) (cons x l)) 

(define (reverse l)
  (foldl rcons '() l))

(define (map f l)
  (if (null? l) l
      (cons (f (car l)) (map f (cdr l)))))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else                       (filter p? (cdr l)))))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (map f l)
  (foldr (lambda (x r) (cons (f x) r)) '() l))

(define (filter p? l)
  (foldr (lambda (x r) (if (p? x) (cons x r) r)) '() l))

(define (accumulate op nv a b term next)
  (foldr op nv (map term (collect a b next))))

(define (id x) x)

(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (car l)) (cdr l))))

