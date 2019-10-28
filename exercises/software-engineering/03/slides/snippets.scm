; Sum of all integers in [a, b]
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a
         (sum-integers (+ a 1) b))))

; Sum of the squares of all integers in [a, b]
(define (sum-squares a b)
  (if (> a b)
      0
      (+ (square a)
         (sum-squares (+ a 1) b))))

; Sum of all (1 / (x^4 + 1)) where x is an integer in [a, b]
(define (sum-fractions a b)
  (if (> a b)
      0
      (+ (/ 1
            (+ (square (square a)) 1))
         (sum-fractions (+ a 1) b))))

; Sum of terms in [a, b]
(define (sum term a b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (+ a 1) b))))

; Sum of all integers in [a, b] using sum
(define (sum-integers a b)
  (sum identity a b))

(define (identity x) x)

; Sum of the squares of all integers in [a, b] using sum
(define (sum-squares a b)
  (sum square a b))

(define (square x) (* x x))

; Sum of the cubes of all integers in [a, b] using sum
(define (sum-cubes a b)
  (sum cube a b))

(define (cube x) (* x x x))

; Sum of all (1 / (x^4 + 1)) where x is an integer in [a, b], using sum
(define (sum-fractions a b)
  (define (term x)
    (/ 1
       (+ (square (square x)) 1)))

  (sum term a b))

; Product of terms in [a, b]
(define (product term a b)
  (if (> a b)
      1
      (* (term a)
         (product term (+ a 1) b))))

; Reducing the integers in [a, b] to a single value using the binary procedure
; combiner
(define (accumulate combiner null-value term a b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (+ a 1)
                            b))))

; Defining sum and product by using accumulate
(define (sum term a b)
  (accumulate + 0 term a b))

(define (product term a b)
  (accumulate * 1 term a b))

; Defining procedures with lambda
(define (square x) (* x x))

(define square (lambda (x) (* x x)))

; Using anonymous procedures (lambdas)
(sum (lambda (x) (* x x)) 1 5) ; 55

(sum (lambda (x) x) 1 5) ; 15
