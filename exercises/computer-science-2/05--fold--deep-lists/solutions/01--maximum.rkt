(define (maximum L)
  (if (null? (cdr L))
      (car L)
      (max (car L) (maximum (cdr L)))))
