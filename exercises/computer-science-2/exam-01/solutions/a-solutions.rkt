;;;;;;;;;; Задача 1

; Връща списък от цифрите на числото `n`.
; Редът на цифрите е обратнен, но в задачата това не ни е проблем.
(define (explode-digits-rev n)
  (if (< n 10)
      (list n)
      (cons (remainder n 10)
            (explode-digits-rev (quotient n 10)))))

(define (product l)
  (foldr * 1 l))

(define (product-digits n)
  (product (explode-digits-rev n)))



(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (minimum-by less? l)
  (foldr (lambda (x rec)
           (if (less? x rec)
               x
               rec))
         (car l)
         (cdr l)))

(define (minimum l)
  (minimum-by < l))

(define (maximum l)
  (minimum-by > l))

(define (diff n)
  (- n (product-digits n)))

(define (largest-diff a b)
  (let ((l (map diff (from-to a b))))
    (- (maximum l) (minimum l))))


;;;;;;;;;; Задача 2

(define (maximum-by less? l)
  (foldr (lambda (x rec)
           (if (less? x rec)
               rec
               x))
         (car l)
         (cdr l)))

(define (sum l)
  (apply + l))

(define (sum-values f l)
  (sum (map f l)))

(define (max-metric ml ll)
  (maximum-by (lambda (m1 m2)
                (< (sum-values m1 ll)
                   (sum-values m2 ll)))
              ml))

;;;;;;;;;; Задача 3

(define (repeat x n)
  (if (= n 0)
      '()
      (cons x (repeat x (- n 1)))))

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (deep-repeat-level dl level)
  (cond ((null? dl) dl)
        ; dl е непразен списък и главата му не е списък
        ((atom? (car dl)) (append (repeat (car dl) level)
                                  (deep-repeat-level (cdr dl) level)))
        ; dl е непразен списък и глава му е списък
        (else (cons (deep-repeat-level (car dl) (+ 1 level))
                    (deep-repeat-level (cdr dl) level)))))

(define (deep-repeat dl)
  ; директните елементи в dl, които са атоми,
  ; искаме да ги повтаряме веднъж, затова първоначално слагаме level = 1.
  (deep-repeat-level dl 1))
