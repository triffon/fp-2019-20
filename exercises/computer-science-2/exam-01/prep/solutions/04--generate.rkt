(define (sq x) (* x x))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (generate a b l)
  (filter (lambda (x)
            (member (* x x) l))
          (from-to a b)))
