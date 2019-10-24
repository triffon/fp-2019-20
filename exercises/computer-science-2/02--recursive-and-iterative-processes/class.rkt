#lang racket

(define (fact-iter n)
  (define (help i result)
    (if (= i n)
        (* result n)
        (help (+ i 1) (* result i))))
  (helper 1 1))


(define (fib-iter n)
  (define (help i a b)
    (if (= i n)
        b
        (help (+ i 1) b (+ a b))))
  (help 1 z0 1))

(define (sum-interval n m)
  (if (> n m)
      0
      (+ n (sum-interval (+ n 1) m))))

(define (sum-interval-iter n m)
  (define (help i result)
    (if (> i m)
        result
        (help (+ i 1) (+ i result))))
  (help n 0))


(define (bool-to-num pred)
  (if pred 1 0))

(define (digit-occurance d n)
  (if (< n 10)
      (bool-to-num (= n d))
      (+ (bool-to-num (= d (remainder n 10)))
         (digit-occurance d (quotient n 10)))))


(define (dc-iter d n)
  (define (help num result)
    (if (< num 10)
        (if (= num d) 1 0)
        (help (quotient num 10)
              (+ result
                 (if (= (remainder num 10) d)
                     1
                     0)))))
  (help n 0))


