(require rackunit rackunit/text-ui)

(define (binomial-coefficient row index)
  (cond ((= index 1) 1)
        ((= row index) 1)
        (else (+ (binomial-coefficient (- row 1) (- index 1))
                 (binomial-coefficient (- row 1) index)))))

(define binomial-coefficient-tests
  (test-suite
    "Tests for binomial-coefficient"

    (check = (binomial-coefficient 1 1) 1)
    (check = (binomial-coefficient 2 1) 1)
    (check = (binomial-coefficient 2 2) 1)
    (check = (binomial-coefficient 3 1) 1)
    (check = (binomial-coefficient 3 2) 2)
    (check = (binomial-coefficient 3 3) 1)
    (check = (binomial-coefficient 4 1) 1)
    (check = (binomial-coefficient 4 2) 3)
    (check = (binomial-coefficient 4 3) 3)
    (check = (binomial-coefficient 4 4) 1)
    (check = (binomial-coefficient 5 1) 1)
    (check = (binomial-coefficient 5 2) 4)
    (check = (binomial-coefficient 5 3) 6)
    (check = (binomial-coefficient 5 4) 4)
    (check = (binomial-coefficient 5 5) 1)
    (check = (binomial-coefficient 6 1) 1)
    (check = (binomial-coefficient 6 2) 5)
    (check = (binomial-coefficient 6 3) 10)
    (check = (binomial-coefficient 6 4) 10)
    (check = (binomial-coefficient 6 5) 5)
    (check = (binomial-coefficient 6 6) 1)))

(run-tests binomial-coefficient-tests)
