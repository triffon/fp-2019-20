(define (snoc x l) (append l (list x)))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (foldr1 op l)
  (if (null? (cdr l)) (car l)
      (op (car l) (foldr1 op (cdr l)))))

(define (maximum x . l) (foldr1 max (cons x l)))

(define (append . ll)
  (if (null? ll) ll
      ; поне 1 параметър
      (let ((l1 (car ll)))
        (if (null? l1) (apply append (cdr ll))
            (cons (car l1) (apply append (cdr l1) (cdr ll)))))))

(define (evali x) (eval x (interaction-environment)))

(define a 2)
(define (id x) x)

(define (apply f l) (evali (cons f l)))
      