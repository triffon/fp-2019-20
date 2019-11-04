(define (prime? number)
  (define (prime?_2 number max)
    (if (= max 1) #t
      (cond
        ((= number 2) #t)
        ((= (remainder number 2) 0) #f)
        ((= (remainder number max) 0) #f)
        ((> (remainder number max) 0) (prime?_2 number (- max 1)))
        (else #t) ; кога влизаме тук?
        )
      )
  )
  (prime?_2 number (floor (sqrt number)))
)

(prime? 1)
(prime? 2)
(prime? 3)
(prime? 5)
(prime? 17)
(prime? 53)
(prime? 22)
(prime? 64)
(prime? 55)
(prime? 1729)
(prime? 41041)
(prime? 134985)
  