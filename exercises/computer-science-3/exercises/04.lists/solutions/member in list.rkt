(define (member? x list)
  (cond
    ((null? list) #f)
    ((if (= x (car list)) #t (member? x (cdr list))))
    (else #f)))

(member? 2 '(1 2 3 4))
(member? 69 '(96 34 68 -2))
