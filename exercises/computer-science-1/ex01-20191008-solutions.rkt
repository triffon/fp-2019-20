; Зад.1
; (10 + 5.16 + 19 + 9.712361) * (20 - (16 - 4))
(* (+ 10 5.16 19 9.712361) (- 20 (- 16 4)))

; 1/4 + 2/5 + 3/8 + 6 * (5.1 - 1.6) * (9/3 - 7/4)
(+ 1/4 2/5 3/8 (* 6 (- 5.1 1.6) (- 9/3 7/4)))

; (16 - 1.32)^2 + 2^(-4)
(+ (expt (- 16 1.32) 2) (expt 2 -4))

; 50^(60 % 7) + ((2^10) % 179)
(+ (expt 50 (remainder 60 7))
   (remainder (expt 2 10) 179))

; 3^(60 ÷ 7) + ((2^10) ÷ 179)
(+ (expt 3 (quotient 60 7))
   (quotient (expt 2 10) 179))

; Зад.2
(define (odd?? n)
  (= (modulo n 2) 1))

(define (even?? n)
  (not (odd?? n)))

; Зад.3
(define (grade n)
  (if (< n 60)
      2
      (+ 3 (exact->inexact
            (/ (- n 60) 40)))))
; Обикновено проверяваме валидността на входа в
; друга функция, която после делегира на основната
(define (grade* n)
  (if (or (negative? n)
          (> n 250))
      "neshto-si"
      (grade n)))

; Зад.4
(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))))

; Зад.5
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

; Зад.7
(define (sq x) (* x x))

(define (my-expt x n)
  (cond ((= n 1) x)
        ((even? n) (sq (my-expt x (/ n 2))))
        (else (* x (sq (my-expt x (quotient n 2)))))))
