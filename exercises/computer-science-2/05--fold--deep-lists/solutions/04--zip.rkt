(define (zip L M)
  (if (or (null? L) (null? M))
      '()
      (cons (cons (car L) (car M))
            (zip (cdr L) (cdr M)))))

