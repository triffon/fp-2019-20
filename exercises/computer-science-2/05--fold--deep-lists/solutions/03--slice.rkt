(define (take n L)
  (if (or (null? L)
          (= n 0))
      '()
      (cons (car L) (take (- n 1) (cdr L)))))

(define (drop n L)
  (if (or (null? L)
          (= n 0))
      L
      (drop (- n 1) (cdr L))))

(define (split a b L)
  (take (+ 1 (- b a)) (drop a L)))
