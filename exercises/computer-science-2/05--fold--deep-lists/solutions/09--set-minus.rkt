(define (set-minus L M)
  (filter (lambda (x)
            (not (member x M)))
          L))
