;;;;;;;;;; Задача 1

; Връща списък от цифрите на числото `n`.
; Редът на цифрите е обратнен, но в задачата това не ни е проблем.
(define (explode-digits-rev n)
  (if (< n 10)
      (list n)
      (cons (remainder n 10)
            (explode-digits-rev (quotient n 10)))))

(define (divides? x n)
  (and (not (= x 0))
       (= (remainder n x) 0)))

(define (sum l)
  (foldr + 0 l))

(define (sum-digit-divisors n)
  (sum (filter (lambda (d)
                 (divides? d n))
               (explode-digits-rev n))))



(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (count-duplicate-pairs l)
  (if (null? l)
      0
      (+ (length (filter (lambda (x) (= x (car l)))
                         (cdr l)))
         (count-duplicate-pairs (cdr l)))))

(define (same-sum a b)
  (count-duplicate-pairs (map sum-digit-divisors (from-to a b))))


;;;;;;;;;; Задача 2

(define (prod l)
  (apply * l))

(define (any? p? l)
  (cond ((null? l) #f)
        ((p? (car l)) #t)
        (else (any? p? (cdr l)))))

(define (all? p? l)
  (not (any? (lambda (x) (not (p? x)))
             l)))

(define (remove x l)
  (cond ((null? l) l)
        ((eq? x (car l)) (cdr l))
        (else (cons (car l) (remove x (cdr l))))))

(define (best-metric? ml ll)
  (any? (lambda (best)
          (all? (lambda (m)
                  (all? (lambda (l)
                          (> (best l)
                             (m l)))
                        ll))
                (remove best ml)))
        ml))

;;;;;;;;;; Задача 3

(define (repeat x n)
  (if (= n 0)
      '()
      (cons x (repeat x (- n 1)))))

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (deep-delete-level dl level)
  (cond ((null? dl) dl)
        ; dl е непразен списък и главата му не е списък
        ((atom? (car dl)) (if (< (car dl) level)
                              (deep-delete-level (cdr dl) level)
                              (cons (car dl) (deep-delete-level (cdr dl) level))))
        ; dl е непразен списък и глава му е списък
        (else (cons (deep-delete-level (car dl) (+ 1 level))
                    (deep-delete-level (cdr dl) level)))))

(define (deep-delete dl)
  ; директните елементи в dl, които са атоми,
  ; имат ниво 1, затова първоначално слагаме level = 1.
  (deep-delete-level dl 1))
