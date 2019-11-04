(define (pow x n)
  (define (pow1 x n result)
    (if (= n 0) result
        (pow1 x (- n 1) (* x result))
     )
   )
  (pow1 x n 1)
)

(define (to-binary number)
  (define (to-binary2 number min result)
    (cond
      ((or (= number 0) (= number 1)) (+ result (* (pow 10 min) number)))
      (else (to-binary2 (quotient number 2) (+ min 1) (+ result (* (pow 10 min) (remainder number 2)))))
    )
  )
  (to-binary2 number 0 0)
)

(to-binary 0)
(to-binary 1)
(to-binary 10)
(to-binary 8)
(to-binary 43)