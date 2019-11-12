(define (make-rat n d)
  (if (= d 0) (make-rat 0 1)
      (if (< d 0) (make-rat (- n) (- d))
          (let ((g (gcd (abs n) d)))
            (cons 'rat (cons (quotient n g) (quotient d g)))))))

(define (rat? p)
  (and (pair? p) (eqv? (car p) 'rat)
       (pair? (cdr p))
       (integer? (cadr p)) (positive? (cddr p))
       (= (gcd (cadr p) (cddr p)) 1)))

(define (check-rat f)
  (lambda (p)
    (if (rat? p) (f p) 'error)))

(define get-numer (check-rat cadr))
(define get-denom (check-rat cddr))

(define (+rat r1 r2)
  (make-rat (+ (* (get-numer r1) (get-denom r2))
               (* (get-numer r2) (get-denom r1)))
            (* (get-denom r1) (get-denom r2))))

(define (pow x n)
  (if (= n 0) 1 (* x (pow x (- n 1)))))

(define (fact n)
  (if (= n 0) 1 (* n (fact (- n 1)))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (1+ n) (+ n 1))

(define (to-fp r) (+ .0 (/ (get-numer r) (get-denom r))))

(define (my-exp x n)
  (accumulate +rat (make-rat 0 1) 0 n (lambda (i) (make-rat (pow x i) (fact i))) 1+))