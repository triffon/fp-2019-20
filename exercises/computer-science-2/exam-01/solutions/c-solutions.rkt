;;;;;;;;;; Задача 1

(define (divides? x n)
  (and (not (= x 0))
       (= (remainder n x) 0)))

(define (divisors n)
  (filter (lambda (x)
            (divides? x n))
          (from-to 1 (- n 1))))

(define (sum l)
  (foldr + 0 l))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (sum-common-divisors n m)
    (sum (filter (lambda (x)
                   (and (divides? x n)
                        (divides? x m)))
                 (from-to 1 (min m n)))))

(define (without x l)
  (filter (lambda (y)
            (not (eq? x y)))
          l))

(define (maximum l)
  ; 0 е най-малката стойност, защото работим с естествени числа.
  (foldr max 0 l))
                   
(define (greatest-sum a b)
      (let ((interval (from-to a b)))
        (maximum (map (lambda (x)
                        (maximum (map (lambda (y) (sum-common-divisors x y))
                                      (without x interval))))
                      interval))))


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

(define (count-metrics ml ll)
  (length (filter (lambda (m)
                    ; v е стойността на m за първия подсписък в ll,
                    (let ((v (m (car ll))))
                      ; проверяваме дали v е равно на
                      ; стойността на m за всички останали подсписъци
                      (all? (lambda (l)
                              (= v (m l)))
                            (cdr ll))))
                  ml)))

;;;;;;;;;; Задача 3

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (level-flatten-level dl level)
  (cond ((null? dl) dl)
        ; в условието специално е отбелязано, че може има атоми, които не са числа. 
        ((atom? dl) (list (if (number? dl)
                              (+ dl level)
                              dl)))
        (else (append (level-flatten-level (car dl) (+ 1 level))
                      (level-flatten-level (cdr dl) level)))))

(define (level-flatten dl)
  (level-flatten-level dl 0))
