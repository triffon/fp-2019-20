(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (deep-foldr op nv term dl)
  (cond ((null? dl) nv)
        ((atom? dl) (term dl))
        (else (op (deep-foldr op nv term (car dl))
                  (deep-foldr op nv term (cdr dl))))))

(define (push-back x L)
  (append L (list x)))

(define (id x) x)

(define (deep-reverse DL)
  (deep-foldr push-back '() id DL))
