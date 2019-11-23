(define (numGame l)
  (foldr (lambda (x rec)
           (and rec
                (or (and (eqv? rec #t)
                         (first-digit x))
                    (if (= (remainder x 10) rec)
                        (first-digit x)
                        #f))))
         #t
         l))
