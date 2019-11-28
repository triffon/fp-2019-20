; lists

(define (enum a b)
  (if (> a b)
      '()
      (cons a (enum (+ a 1) b))))

(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

(define (square x) (* x x))

; too ineficient
(define first-square
  (car (map square (enum 1 100000))))

(display first-square)
(newline)