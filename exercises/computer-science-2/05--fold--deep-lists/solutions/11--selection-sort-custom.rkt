(define (remove x L)
  (cond ((null? L) L)
        ((equal? x (car L)) (cdr L))
        (else (cons (car L) (remove x (cdr L))))))

(define (minimum less? L)
  (define (my-min a b)
    (if (less? a b) a b))

  (if (null? (cdr L))
      (car L)
      (my-min (car L) (minimum less? (cdr L)))))

(define (selection-sort less? L)
  (if (null? L)
      L
      (let ((m (minimum less? L)))
        (cons m (selection-sort less? (remove m L))))))
