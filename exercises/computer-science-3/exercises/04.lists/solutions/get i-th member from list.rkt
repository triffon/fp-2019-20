(define (list-ref2 list i)
  (cond
    ((< i 0) "not a valid i")
    (else (if (= i 0) (car list) 
         (list-ref2 (cdr list) (- i 1))))))
    
    
    

(list-ref2 '(5 9 2) 0)
(list-ref2 '(1 8 6 2 3) 4)
(list-ref2 '(3 4 5) -3)

