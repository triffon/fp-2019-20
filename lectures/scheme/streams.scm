; Това би работило, но delay* в Scheme
; е обикновена функция, т.е. би оценила
; аргумента си стриктно - точно
; обратното на желания ефект.
;  (define (delay* x)
;    (lambda () x))
;  (define (force* p)
;    (p))

(define neshto (delay (+ 2 3)))

; Работи, когато заместим извикването
; на delay* с неговото тяло
(define error (lambda () (car '())))

; Специални форми в Scheme:
; delay, quote, define, let, let*, letrec, if, and,
; or, cond, case, lambda, begin, define-syntax

; Работи, т.к. a не се оценява докато не поискаме.
(define b (delay (+ a 3)))

; Не е задължително празният поток
; да е '() - може да е #f или числото 5.
(define empty-stream '())
(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t)
                    (cons h (delay t)))))

(define (head str) (car str))
(define (tail str) (force (cdr str)))
(define empty-stream? null?)

; Аналогично на примера с (define b (delay (+ a 3)))
(define test
  (cons-stream 1
    (cons-stream a
      (cons-stream 3 empty-stream))))

(define (enum a b)
  (if (> a b)
      empty-stream
      (cons-stream a (enum (+ a 1) b))))

; Най-полезната функция при работа с потоци:
; да вземем първите n числа в обикновен списък
(define (first n s)
  (if (or (empty-stream? s) (= n 0)) '()
      (cons (head s) (first (- n 1) (tail s)))))

; Функция, връщаща поток от всички числа, >=n.
;(define (from n) (cons-stream n (from (+ n 1))))
; Всички естествени числа
;(define nats (from 0))

; Генератор на поток от числата на Фибоначи, започвайки
; от двете последователни числа a и b.
(define (generate-fibs a b)
  (cons-stream a (generate-fibs b (+ a b))))
;(define fibs (generate-fibs 0 1))

; Трансформиране (map)
(define (map-stream f s)
  (cons-stream (f (head s))
               (map-stream f (tail s))))

; Филтриране (filter)
(define (filter-stream p? s)
  (if (p? (head s))
      (cons-stream (head s) (filter-stream p? (tail s)))
      (filter-stream p? (tail s))))

; Комбиниране (zip)
(define (zip-streams op s1 s2)
  (cons-stream (op (head s1) (head s2))
               (zip-streams op (tail s1) (tail s2))))

; Дефиниции чрез директна рекурсия
(define ones (cons-stream 1 ones))
(define nats
  (cons-stream 0 (zip-streams + ones nats)))

(define (fib n)
  (if (< n 2) n
      (+ (fib (- n 1)) (fib (- n 2)))))

; Пример: няма мемоизация между две отделни извиквания на bar
; => мемоизираните стойности живеят в средата, в която извикваме
; force и умират с нея, когато тя бъде унищожена
(define (bar x)
  (define big (delay (fib 35)))
  (+ x (force big)))

(define fibs
  (cons-stream 0
    (cons-stream 1
      (zip-streams + fibs (tail fibs)))))

(define (notdivides d)
  (lambda (n) (> (remainder n d) 0)))

(define (sieve stream)
  (cons-stream (head stream)
    (sieve (filter-stream
            (notdivides (head stream))
            (tail stream)))))

(define primes (sieve (tail (tail nats))))





