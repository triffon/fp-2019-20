(define (intersection L M)
  (filter (lambda (x)
            (member x M))
          L))


(define (unique L)
  (if (null? L)
      L
      (let ((h (car L)))
        (cons h (unique (filter (lambda (x)
                                  (not (equal? x h)))
                                L))))))

(define (union L M)
  (unique (append L M)))

(define (set-minus L M)
  (filter (lambda (x)
            (not (member x M)))
          L))

