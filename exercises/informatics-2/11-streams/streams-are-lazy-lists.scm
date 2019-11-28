; lists -> stream
; cons -> stream-cons
; car -> head
; cdr -> tail
; null? -> stream-empty?
; '() -> the-empty-stream

(define-syntax delay
  (syntax-rules () ((delay x)
                    (lambda () x))))

(define (force x) (x))


(define-syntax stream-cons
  (syntax-rules () ((stream-cons h t)
                    (cons h (delay t)))))

(define head car)

(define (tail stream)
  (force (cdr stream)))

(define stream-empty? null?)

(define the-empty-stream '())

(define (stream-enum a b)
  (if (> a b)
      the-empty-stream
      (stream-cons a
                   (stream-enum (+ a 1) b))))

(define (stream-map f s)
  (if (stream-empty? s)
      the-empty-stream
      (stream-cons (f (head s))
                   (stream-map f (tail s)))))

(define (square x) (* x x))

(define first-square
  (head (stream-map square (stream-enum 1 100000000000000))))

(display first-square)
(newline)

; infinite streams

(define (from n)
  (stream-cons n (from (+ n 1))))

(define (stream-take n s)
  (if (= n 0)
      the-empty-stream
      (stream-cons (head s)
                   (stream-take (- n 1)
                                (tail s)))))

(define (stream-list s)
  (if (stream-empty? s)
      '()
      (cons (head s)
            (stream-list (tail s)))))

(define naturals (from 0))

(display (stream-list (stream-take 10 naturals)))
