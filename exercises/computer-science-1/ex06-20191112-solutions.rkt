; test
(define (foldr op nv lst)
  (if (null? lst)
      nv
      (op (car lst) (foldr op nv (cdr lst)))))

(define (prod l) (apply * l))
(define (sum l) (apply + l))

(define (max-metric ml ll)
  (define (evaluate f)
    (foldr + 0 (map f ll)))
  (define (for currMax l)
    (cond ((null? l) currMax)
          ((> (evaluate (car l))
              (evaluate currMax))
           (for (car l) (cdr l)))
          (else
           (for currMax (cdr l)))))
  (for (car ml) (cdr ml)))

(define (deep-repeat lst)
  (define (repeat x n)
    (if (= n 0)
        '()
        (cons x (repeat x (- n 1)))))
  (define (helper lst lvl)
    (cond ((null? lst) '())
          ((list? (car lst))
           (cons
            (helper (car lst) (+ lvl 1))
            (helper (cdr lst) lvl)))
          (else
           (append
            (repeat (car lst) lvl)
            (helper (cdr lst) lvl)))))
  (helper lst 1))

(define (delete x lst)
  (cond ((null? lst) '())
        ((= x (car lst))
         (delete x (cdr lst)))
        (else
         (cons (car lst)
               (delete x (cdr lst)))))
          