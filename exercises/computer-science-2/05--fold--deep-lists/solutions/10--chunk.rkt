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

(define (chunk n L)
  (if (null? L)
      L
      (cons (take n L)
            (chunk n (drop n L)))))
