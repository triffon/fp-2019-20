; Вариант 1 за имплементиране на наши force и delay.
; В този случай функции като zip-streams не работят, т.к.
; когато cons-stream вика quote, за рекурсивното извикване
; се запазва символа 'op, а не функцията, която стои зад него.
;  (define-syntax delay*
;    (syntax-rules () ((delay* x) (quote x))))
;  (define (force* p)
;    (eval p (interaction-environment)))

; Вариант 2: работи :)
(define-syntax delay*
  (syntax-rules () ((delay* x) (lambda () x))))
(define (force* p) (p))

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay* t)))))

(define (head str) (car str))
(define (tail str) (force* (cdr str)))

(define (zip-streams op s1 s2)
  (cons-stream (op (head s1) (head s2))
               (zip-streams op (tail s1) (tail s2))))

(define ones (cons-stream 1 ones))
(define nats
  (cons-stream 0
               (zip-streams + ones nats)))

(define (first n s)
  (if (= n 0) '()
      (cons (head s) (first (- n 1) (tail s)))))

(length (first 100 nats))
