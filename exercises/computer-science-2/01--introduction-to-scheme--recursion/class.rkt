#lang racket
(define zad1 (+ 10 5.16 19 9.7123123))
(define x (modulo 5 2)) ; остатък
(define y (quotient 19 2)) ; целочислено деление
(define z (/ 1 4))

(define (my-odd? number) (= (modulo number 2) 1))

(define (my-even? number) (not (my-odd? number)))

(define (get-grade points)
  (if (>= points 180)
      6
      (if (>= points 140)
          5
          (if (>= points 100)
              4
              (if (>= points 60)
                  3
                  2)))))

(define (get-grade2 points)
  (cond ((>= points 180) 6)
        ((>= points 140) 5)
        ((>= points 100) 4)
        ((>= points 60) 3)
        (else 2)))


(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(define (fib n)
  (if (or (= n 0) (= n 1))
      n
      (+ (fib (- n 1)) (fib (- n 2))))))
