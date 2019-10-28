; Linear recursive process
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

; Linear iterative process
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; Nested definitions
(define (factorial n)
  (define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))

  (fact-iter 1 1 n))

; iter has access to all arguments of factorial
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))

  (iter 1 1))
