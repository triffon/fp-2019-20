#lang racket
(define (id x) x)

(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (quotient n 10)))))

(define (middle-digit n)
  (let ((dc (count-digits n)))
    (if (even? dc)
        -1
        (remainder (quotient n (expt 10 (quotient dc
                                                  2)))
                 10))))


(define (all? p? l)
  (if (null? l)
      #t
      (if (p? (car l))
          (all? p? (cdr l))
          #f)))

(define (is-em? l op f)
;  (define (sv1 l1)
;    (if (null? l1)
;        #t
;        (if (member (car l1) l)
;            (sv1 (cdr l1))
;            #f)))
 (and 
    (all? (lambda (x)
            (member (f x) l))
          l)
  
    (all? (lambda (x)
            (all? (lambda (y)
                    (= (op (f x)(f y)) (f (op x y))))
                  l))
          l)))


  
(define (func l)
  (all? (lambda (x)
          (all? (lambda (y)
                  (> (+ x y) -10))
                l))
        l))



(define (remove x l)
  (if (null? l)
      l
      (if (equal? (car l) x)
          (cdr l)
          (cons (car l) (remove x (cdr l))))))


(define (minimum l)
  (if (null? (cdr l))
      (car l)
      (min (car l) (minimum (cdr l)))))
  
(define (selection-sort l)
  (if (null? l)
      l
      (let ((m (minimum l)))
        (cons m (selection-sort (remove m l))))))


(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ 1 a) b))))

(define (any? p? l)
  (if (null? l)
      #f
      (or (p? (car l))
          (any? p? (cdr l)))))

(define (meet-twice? f g a b)
  (define l (from-to a b))
  (any? (lambda (x)
          (any? (lambda (y)
                  (and (not (= x y))
                       (= (f x) (g x))
                       (= (f y) (g y))))
                l))
        l))

(define (next-look-and-say l)
  (define (count x l1)
    (if (null? l1)
        0
        (if (= (car l1) x)
            (+ 1 (count x (cdr l1)))
            0)))
  (if (null? l)
      l
      (let ((c (count (car l) l)))
           (cons c
                 (cons (car l)
                       (next-look-and-say (drop l c)))))))

(define (quicksort l)
  (if (or (null? l) (null? (cdr l)))
      l
      (let ((pivot (car l)))
        (append
          (quicksort (filter (lambda (x) (<= x pivot)) (cdr l)))
          (list pivot)
          (quicksort (filter (lambda (x) (> x pivot)) l))))))

(define (list? x)
  (or (null? x)
      (and (pair? x)
           (list? (cdr x)))))
(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define dl1 '((1 2) ((4 5)) (3 (0))))

(define (count-atoms dl)
  (cond ((null? dl) 0)
        ((atom? dl) 1)
        (else (+ (count-atoms (car dl))
                 (count-atoms (cdr dl))))))
(define (flatten dl)
  (cond ((null? dl) '())
        ((atom? dl) (list dl))
        (else (append (flatten (car dl))
                      (flatten (cdr dl))))))

(define (deep-foldr op nv term dl)
  (cond ((null? dl) nv)
        ((atom? dl) (term dl))
        (else (op (deep-foldr op nv term (car dl))
                  (deep-foldr op nv term (cdr dl))))))

(define (foldl op v l)
  (if (null? l)
      v
      (foldl op (op v (car l)) (cdr l))))

(define (deep-foldl op nv term dl)
  (foldl (lambda (acc x)
           (if (atom? x)
               (op acc (term x))
               (op acc (deep-foldl op nv term x))))
         nv dl))

(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

 (define (calcPoly l x)
   (my-foldl (lambda (a b) (+ (* a x) b) )
          0        
          l))       

(define (flip f) (lambda (x y) (f y x) ) )

(define (my-foldl op nv l)
  (foldr (flip op)
         nv
         (reverse l)) )

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (plus a b)
  (+ a b))
(define (plus* a)
  (lambda (b)
    (+ a b)))

(define (foldl* op nv l)
  ((foldr (lambda (x rec)
           (compose rec
                    (lambda (y)
                      (op y x))
                    ))
         id
         l)
   nv))

(define (push-back x l)
  (append l (list x)))

(define (explode-digits n)
  (if (< n 10)
      (list n)
      (push-back (remainder n 10)
                 (explode-digits (quotient n 10)))))
       
(define (first-digit n)
  (car (explode-digits n)))
  

(define (numGame l)
  (foldr (lambda (x rec)
           (and rec
                (or (and (eqv? rec #t)
                         (first-digit x))
                    (if (= (remainder x 10) rec)
                        (first-digit x)
                        #f))))
         #t
         l))
