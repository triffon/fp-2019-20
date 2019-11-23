(define (foldl op v l)
  (if (null? l)
      v
      (foldl op (op v (car l)) (cdr l))))

(define (calcPoly l x)
  (foldl (lambda (acc a)
           (+ (* acc x) a))
         0
         l))
