(define (list-ref2 list i)
  (cond
    ((< i 0) "not a valid i")
    (else (if (= i 0) (car list) 
         (list-ref2 (cdr list) (- i 1))))))

(define (last xs)
  (list-ref2 xs (- (length xs) 1)))

(last '(5 9 2))
(last '(1 8 6 2 3))
(last '(1))