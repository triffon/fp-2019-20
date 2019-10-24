(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (accumulate-i op nv a b term next)
  (if (> a b) nv
      (accumulate-i op (op nv (term a)) (next a) b term next)))

(define (sum a b term next)
  (accumulate + 0 a b term next))

(define (product a b term next)
  (accumulate * 1 a b term next))

(define (square x) (* x x))
(define (1+ x) (+ x 1))
(define (id x) x)

(define (p n x)
  (define (term i) (* (- (1+ n) i) (expt x i)))
  (accumulate + 0 0 n term 1+))

(define (p n x)
  (define (op u v) (+ (* u x) v))
  (accumulate op 0 1 (1+ n) id 1+))

(define (p n x)
  (define (op u v) (+ (* v x) u))
  (accumulate op 0 1 (1+ n) id 1+))

(define (p n x)
  (define (op u v) (+ (* u x) v))
  (accumulate-i op 0 1 (1+ n) id 1+))

(define (fact n)
  (accumulate * 1 1 n id 1+))

(define (pow x n)
  (accumulate * 1 1 n (lambda (i) x) 1+))

(define (myexp x n)
  (accumulate + 0. 0 n
              (lambda (i) (/ (pow x i) (fact i)))
              1+))

(define (myexp x n)
  (accumulate (lambda (u v) (+ 1 (* (/ x u) v))) 1. 1 n id 1+))

(define (myexp x n)
  (accumulate (lambda (u v) (+ 1 (* u v))) 1. 1 n (lambda (i) (/ x i)) 1+))

(define (exists? a b p?)
  (accumulate (lambda (u v) (or u v)) (or) a b p? 1+))

(define (prime? n)
  (and (> n 1) (not (exists? 2 (sqrt n) (lambda (d) (= (remainder n d) 0))))))

(define (derive f dx)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x)) dx)))

(define (n+ n) (lambda (i) (+ i n)))
(define 5+ (n+ 5))

(define (compose f g) (lambda (x) (f (g x))))

(define 2* (derive square 0.00001))

(define (repeated f n)
  (lambda (x)
    (if (= n 0) x
        (f ((repeated f (- n 1)) x)))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (repeated f n)
  (if (= n 0) id (compose f (repeated f (- n 1)))))

(define (repeated f n)
  (accumulate compose id 1 n (lambda (i) f) 1+))

(define (derive-n f n dx)
  (if (= n 0) f
      (derive (derive-n f (- n 1) dx) dx)))

(define (derive-n f n dx)
  ((repeated (lambda (g) (derive g dx)) n) f))

(define (derive-n f n dx)
  ((accumulate compose id 1 n (lambda (i) (lambda (g) (derive g dx))) 1+) f))

(define my-#t (lambda (x y) x))
(define my-#f (lambda (x y) y))
(define (lambda-if b x y) ((b x y)))

(define (gamma f)
  (lambda (n)
    (if (= n 0) 1 (* n (f (- n 1))))))
(define (fact n) ((gamma fact) n))

(define (fact n) (((repeated gamma (+ n 1)) 'empty) n))

(define (Y g)
  (define (gamma-inf me) (lambda (n) ((g (me me)) n)))
  (gamma-inf gamma-inf))

(define fact (Y gamma))