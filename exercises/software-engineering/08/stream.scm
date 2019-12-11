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

(define (take-stream n s)
  (if (or (= n 0)
          (empty-stream? s))
      empty-stream
      (cons-stream (head s)
            (take-stream (- n 1) (tail s)))))

(define (stream->list s)
  (if (empty-stream? s)
      '()
      (cons (head s)
            (stream->list (tail s)))))
