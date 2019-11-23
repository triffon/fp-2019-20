;#lang racket

; 1. length
(define (length* lst)
  (if (null? lst)
    0
    (+ 1
       (length* (cdr lst)))))
; 2. sum
(define (sum lst)
  (if (null? lst)
    0
    (+ (car lst)
       (sum (cdr lst)))))

; 3. last
(define (last* lst)
  (if (null? (cdr lst))
    (car lst)
    (last (cdr lst))))

; 4. nth
(define (nth n lst)
  (define (help i lst)
    (cond [(null? lst) 'not-found]
          [(= i n) (car lst)]
          [else (help (+ 1 i) (cdr lst))]))
  (help 0))

; 5. concat
(define (concat lst1 lst2)
  (if (null? lst1)
    lst2
    (cons
      (car lst1)
      (concat (cdr lst1) lst2))))

; 6. map
(define (map* f lst)
  (if (null? lst)
    lst
    (cons
      (f (car lst))
      (map* f (cdr lst)))))

; 7. filter
(define (filter* p lst)
  (cond [(null? lst) lst]
        [(p (car lst))
         (cons
           (car lst)
           (filter* p (cdr lst)))]
        [else (filter* p (cdr lst))]))

; 8. partition
(define (partition* p lst)
  (define (help truthy falsy lst)
    (cond [(null? lst) (cons truthy (list falsy))]
          [(p (car lst))
           (help (cons (car lst) truthy)
                 falsy
                 (cdr lst))]
          [else (help truthy
                      (cons (car lst) falsy)
                      (cdr lst))]))
  (help '() '() lst))

