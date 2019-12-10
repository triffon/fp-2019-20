(load "./stream.scm")

(define (repeat value)
  (cons-stream value (repeat value)))

(define (take-stream n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (take-stream (- n 1) (tail s)))))
