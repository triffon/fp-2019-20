(define (remove x L)
  (cond ((null? L) L)
        ((equal? x (car L)) (cdr L))
        (else (cons (car L) (remove x (cdr L))))))

(define (minimum L)
  (if (null? (cdr L))
      (car L)
      (min (car L) (minimum (cdr L)))))

(define (selection-sort L)
  (if (null? L)
      L
      (let ((m (minimum L)))
        (cons m (selection-sort (remove m L))))))
