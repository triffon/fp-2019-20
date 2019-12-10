(load "./stream.scm")

(define (cycle l)
  (if (null? l)
      empty-stream
      (cons-stream (car l)
                   (cycle (append (cdr l)
                                  (list (car l)))))))

(define (take-stream n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (take-stream (- n 1) (tail s)))))
