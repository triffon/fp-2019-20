(load "./stream.scm")

(define (iterate f x)
  (cons-stream x (iterate f (f x))))

(define (take-stream n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (take-stream (- n 1) (tail s)))))
