#lang racket

; count-digits
(define (count-digits n)
  (if (< n 10)
    1
    (+ 1 (count-digits (quotient n 10)))))

; pow
(define (pow x n)
  (if (zero? n)
    1
    (* x (pow x (- n 1)))))

; interval-sum
(define (interval-sum a b)
  (if (= a b)
    b
    (+ a (interval-sum (+ a 1) b))))

; count-digits-i
(define (count-digits-i n)
  (define (iter counter number)
    (if (< number 10)
      counter
      (iter (+ counter 1)
            (quotient number 10))))
  (iter 1 (abs n)))

; interval-sum-i
(define (interval-sum-i a b)
  (define (iter i j acc)
    (if (= i j)
      (+ acc i)
      (iter (+ i 1)
            j
            (+ acc i))))
  (if (< a b)
    (iter a b 0)
    (iter b a 0)))

; reverse-digits-i
(define (reverse-digits-i n)
  (define (iter number result)
    (if (zero? number)
      result
      (iter (quotient number 10)
            (+ (* result 10)
               (remainder number 10)))))
  (iter n 0))

; pow-i
(define (pow-i x n)
  (define (iter step accumulator)
    (if (zero? step)
      accumulator
      (iter (- step 1)
            (* accumulator x))))
  (if (negative? n)
    (/ 1 (iter (- n) 1))
    (iter n 1)))

; fast-pow
(define (fast-pow x n)
  (define (iter base exponent accumulator)
    (cond [(zero? exponent) accumulator]
          [(even? exponent)
           (iter (* base base)
                 (/ exponent 2)
                 accumulator)]
          [else (iter base
                      (- exponent 1)
                      (* accumulator base))]))
  (if (negative? n)
      (/ 1 (iter x (- n) 1))
      (iter x n 1)))
