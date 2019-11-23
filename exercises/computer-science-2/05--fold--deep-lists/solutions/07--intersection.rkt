(define (intersection L M)
  (filter (lambda (x)
            (member x M))
          L))
