(define (repeat x n)
  (if (= n 0)
      '()
      (cons x
            (repeat x (- n 1)))))

(define (flatmap f l)
  (apply append (map f l)))

(define (run-length-decode code)
  (flatmap (lambda (kv)
             (repeat (car kv) (cdr kv)))
           code))
