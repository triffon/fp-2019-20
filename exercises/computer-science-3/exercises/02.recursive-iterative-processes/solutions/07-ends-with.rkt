(define (ends-with? number test)
  (cond
    ((and (< test 10) (= (remainder number 10) test) #t))
    ((= (remainder number 10) (remainder test 10)) (ends-with? (quotient number 10) (quotient test 10)))
    (else #f)
    )
  )
; alternative
(define (ends-with number test)
  (define (digits-count number)
    (if (> 10 number)
        1
        (+ 1 (digits-count (quotient number 10)))))
  (let ((test-digits-count (digits-count test)))
    (= (remainder (- number test) (expt 10 test-digits-count)) 0)))

(ends-with? 7 7)
(ends-with? 7 5)
(ends-with? 3141 14)
(ends-with? 1718 18)
(ends-with? 12345 45)
(ends-with? 969 96)
(ends-with? 46 46)