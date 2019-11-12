(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (flatten dl)
  (cond ((null? dl) '())
        ((atom? dl) (list dl))
        (else (append (flatten (car dl))
                      (flatten (cdr dl))))))
