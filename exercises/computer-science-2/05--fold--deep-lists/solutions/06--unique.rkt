(define (unique L)
  (if (null? L)
      L
      (let ((h (car L)))
        (cons h (unique (filter (lambda (x)
                                  (not (equal? x h)))
                                L))))))
