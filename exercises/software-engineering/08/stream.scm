(define empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
                ((cons-stream h t)
                 (cons h (delay t)))))

(define (empty-stream? s)
  (equal? s empty-stream))

(define head car)

(define (tail s)
  (force (cdr s)))
