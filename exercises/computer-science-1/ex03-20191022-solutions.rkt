; Зад.0
(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a)
          (accumulate op nv (next a) b term next))))

(define (filter-accum p? op nv a b term next)
  (cond ((> a b) nv)
        ((p? a) (op (term a)
                    (filter-accum p? op nv (next a) b term next)))
        (else (filter-accum p? op nv (next a) b term next))))

; Зад.1
(define (!! n)
  (accumulate * 1
              (if (odd? n) 1 2) n
              (lambda (i) i)
              (lambda (i) (+ i 2))))

; Зад.2
(define (nchk n k)
  (define (fact n)
    (accumulate * 1 1 n (lambda (i) i) (lambda (i) (+ i 1))))
  (/ (fact n) (* (fact k) (fact (- n k)))))

; Зад.3
(define (nchk* n k)
  (accumulate * 1 1 k
              (lambda (i) (/ (+ n (- k) i) i))
              (lambda (i) (+ i 1))))

; Зад.4
(define (2^ n)
  (accumulate * 1 1 n (lambda (i) 2) (lambda (i) (+ i 1))))
; Можем да използваме и (constantly 2) за term

(define (2^^ n)
  (accumulate + 0
              0 n
              (lambda (i) (nchk* n i))
              (lambda (i) (+ i 1))))

; Зад.5
(define (divisors-sum n)
  (accumulate + 0
              1 n
              (lambda (i) ; "фалшиво" филтриране с вмъкване на неутралната стойност
                (if (zero? (remainder n i))
                    i
                    0))
              (lambda (i) (+ i 1))))

; По-доброто решение
(define (divisors-sum* n)
  (filter-accum (lambda (i) (= 0 (remainder n i)))
                + 0
                1 n
                (lambda (i) i)
                (lambda (i) (+ i 1))))

; Зад.6
(define (count p? a b)
  (accumulate + 0
              a b
              (lambda (i) (if (p? i) 1 0))
              (lambda (i) (+ i 1))))

; Зад.6.5
(define (all? p? a b)
  (accumulate (lambda (x y) (and x y))
              #t
              a b
              p? ; термът е самият предикат - насъбираме
                 ; върнатите от него булеви стойности
              (lambda (i) (+ i 1))))

(define (any? p? a b)
  (accumulate (lambda (x y) (or x y))
              #f
              a b
              p?
              (lambda (i) (+ i 1))))
; Можем да използваме и count и да сравняваме резултата с n или 0.
; Можем и да използваме закона на ДеМорган:
; (define (any? p? a b) (not (all? (complement p?) a b)))
; или обратното :)

; Зад.7
(define (prime? n)
  (not (or (= n 1)
           (any? (lambda (k) (zero? (remainder n k))) 2 (/ n 2)))))

; Зад.8
(define (constantly c)
  (lambda (x) c))

; Зад.9
(define (flip f)
  (lambda (x y) (f y x)))

; Зад.10
(define (complement p)
  (lambda (x) (not (p x))))

; Зад.11
(define (twist k f g)
  (if (= k 0)
      (lambda (x) x)
      (lambda (x) (f (g ((twist (- k 2) f g) x))))))
;                        ^^^^^^^^^^^^^^^^^^^
; Резултатът от рекурсивното twist е функция => извикваме го като фунцкия

(define (twist* k f g)
  ; Композицията на функции е нова функция
  (define (compose f g) (lambda (x) (f (g x))))
  (accumulate compose
              (lambda (x) x) ; коя е неутралната стойност на композицията на функции?
              1 k
              (lambda (i) (if (odd? i) f g))
              (lambda (i) (+ i 1))))

; Зад.12
(define (permutable? f g a b)
  (filter-accum even?
                (lambda (x y) (and x y))
                #t
                a b
                (lambda (k)
                  (= ((twist k f g) k)
                     ((twist k g f) k)))
                (lambda (k) (+ k 1))))

; По-доброто решение
(define (permutable?? f g a b)
  (all? (lambda (k)
          (or (odd? k)
              (= ((twist k f g) k)
                 ((twist k g f) k))))
        a b))
