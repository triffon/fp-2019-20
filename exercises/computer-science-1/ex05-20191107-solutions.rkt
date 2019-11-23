; Стандартни функции:
(define (foldr op nv lst)
  (if (null? lst)
      nv
      (op (car lst) (foldr op nv (cdr lst)))))

(define (filter p? lst)
  (foldr (lambda (el res)
           (if (p? el) (cons el res) res))
         '()
         lst))
        
; Зад.1.
(define (take n lst)
  (cond ((null? lst) '())
        ((= n 0) '())
        (else (cons (car lst)
                    (take (- n 1) (cdr lst))))))

(define (drop n lst)
  (cond ((null? lst) '())
        ((= n 0) lst)
        (else (drop (- n 1) (cdr lst)))))

; Зад.2.
(define (all? p? lst)
  (or (null? lst)
      (and (p? (car lst))
           (all? p? (cdr lst)))))
; Дори така написани, симетрията между двете е очевидна
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (car lst))
           (any? p? (cdr lst)))))

; Зад.3.
(define (zip lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (cons (car lst1) (car lst2))
            (zip (cdr lst1) (cdr lst2)))))

; Зад.4.
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (f (car lst1) (car lst2))
            (zip (cdr lst1) (cdr lst2)))))
;(define (zip lst1 lst2)
;  (zipWith cons lst1 lst2))

; Зад.5.
(define (sorted? lst)
  (or (null? lst)
      (null? (cdr lst)) ; щом достъпваме по 2 ел-та, трябва да сме сигурни че съшествуват
      (and (<= (car lst) (cadr lst))
           (sorted? (cdr lst)))))

; Зад.6.
; Рекурсивно решение, един начин:
(define (remove-dupl1 lst)
  (if (null? lst)
      '()
      (cons (car lst)
            (remove-dupl1 (filter (lambda (x) (not (equal? x (car lst))))
                                  (cdr lst))))))
; Друг начин:
(define (remove-dupl2 lst)
  (cond ((null? lst) '())
        ((member (car lst) (cdr lst)) (remove-dupl2 (cdr lst)))
        (else (cons (car lst) (remove-dupl2 (cdr lst))))))
; Итеративен вариант:
(define (remove-dupl3 lst)
  (define (for lst res)
    (cond ((null? lst) res)
          ((member (car lst) res) (helper (cdr lst) res))
          (else (helper (cdr lst) (cons (car lst) res)))))
  (for lst '()))
; Everything can be a fold: най-елегантното решение
(define (remove-dupl4 lst)
  (foldr (lambda (el res)
           (if (member el res) res (cons el res)))
         '()
         lst))

; Зад.7.
(define (insert val lst)
  (cond ((null? lst) (list val)) ; стигнали сме до края
        ((> val (car lst)) (cons (car lst)
                                  (insert val (cdr lst))))
        (else (cons val lst))))

; Зад.8.
(define (insertion-sort lst)
  (foldr insert '() lst))

; Зад.9.
(define (sub? i1 i2) ; дали i1 е подинтервал на i2
  (and (>= (car i1) (car i2))
       (<= (cdr i1) (cdr i2))))

(define (max-interval lst) ; максимален по дължина интервал
  (define (int-length i) ; дължина на интервал
    (- (cdr i) (car i)))
  (define (for currMax lst)
    (cond ((null? lst) currMax)
          ((> (int-length (car lst)) (int-length currMax))
             (for (car lst) (cdr lst)))
          (else
             (for currMax (cdr lst)))))
  ; При търсене на мин/макс взимаме първия елемент
  ; като първоначален и обхождаме останалите.
  (for (car lst) (cdr lst)))

(define (longest-interval-subsets lst)
  (define longest (max-interval lst)) ; за да не го преизчисляваме непрекъснато
  (filter (lambda (i) (sub? i longest)) lst))

; Зад.10.
(define (compose . fns)
  (define (compose2 f g) (lambda (x) (f (g x))))
  (define id (lambda (x) x)) ; идентитет
  (foldr compose id fns))

; Зад.11.
(define (group-by f lst)
  (define uniques (remove-dupl4 (map f lst)))
  (define (filter-by res) ; всички ел-ти на списъка, даващи резултат res
    (filter (lambda (x) (equal? res (f x))) lst))
  (map (lambda (res) (cons res (list (filter-by res))))
       uniques))

; Зад.12.
(define (zipWith* f . lsts)
  ; Ще си направим обикновена функция,
  ; приемаща обикновен списък от списъци...
  (define (helper lsts)
    (if (any? null? lsts)
        '()
        (cons (apply f (map car lsts))
              (helper (map cdr lsts)))))
  ; И просто ще ѝ подадем списъка от аргументи,
  ; които специалната ни функция е получила
  (helper lsts))

; Стандартно:
(define (foldl op nv lst)
  (if (null? lst)
      nv
      (foldl op (op nv (car lst)) (cdr lst))))

(define (atom? x) (not (pair? x)))
(define (deep-foldr nv term op dl)
  (cond ((null? dl) nv)
        ((atom? dl) (term dl))
        (else (op (deep-foldr nv term op (car dl))
                  (deep-foldr nv term op (cdr dl))))))

; Зад.13.
(define (range a b) ; интервал от числа, включително
  (if (> a b) '()
      (cons a (range (+ a 1) b))))
(define (try-split x)
  ; to-do: функция, която разбива x на (y . z) ако е възможно,
  ; и връща x иначе
  x)
(define (split-squares dl)
  (deep-foldr '() try-split cons dl))

; Зад.14.
(define (fake-foldr op nv lst)
  (deep-foldr nv
              (lambda (x) x)
              op
              lst))
              