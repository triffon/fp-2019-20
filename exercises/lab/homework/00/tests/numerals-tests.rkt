#lang racket

(require quickcheck
         rackunit
         rackunit/quickcheck)

(require (prefix-in solutions. "../solutions/numerals.rkt"))

(define zero (lambda (s z) z))
(define one (lambda (s z) (s z)))
(define two (lambda (s z) (s (s z))))
(define ten (lambda (s z) (s (s (s (s (s (s (s (s (s (s z))))))))))))
(define twelve (lambda (s z) (s (s (s (s (s (s (s (s (s (s (s (s z))))))))))))))

(define (times2 x) (* 2 x))
(define (pow2 x) (expt 2 x))


; no easy way to do the other roundtrip property
; without adding a solution to the task in the tests ;/
(define from-to-id
  (property ((n (choose-integer 0 100)))
    (= n (solutions.from-numeral (solutions.to-numeral n)))))

; we rely on {from,to}-numeral being correct in these cases
; otherwise we have to write a solution here
(define plus-zero-id
  (property ((n (choose-integer 0 100)))
    (let ((m (solutions.to-numeral n)))
      (and
        (= n (solutions.from-numeral (solutions.plus zero m)))
        (= n (solutions.from-numeral (solutions.plus m zero)))))))

(define mult-one-id
  (property ((n (choose-integer 0 100)))
    (let ((m (solutions.to-numeral n)))
      (and
        (= n (solutions.from-numeral (solutions.mult one m)))
        (= n (solutions.from-numeral (solutions.mult m one)))))))

; N.B.: don't pick too large numbers! mult takes a while
(define (oper-commut op)
  (property ((n (choose-integer 0 100))
             (m (choose-integer 0 100)))
    (let ((n* (solutions.to-numeral n))
          (m* (solutions.to-numeral m)))
      (= (solutions.from-numeral (op n* m*))
         (solutions.from-numeral (op m* n*))))))

(define (oper-model op op-numerals)
  (property ((n (choose-integer 0 100))
             (m (choose-integer 0 100)))
    (let ((n* (solutions.to-numeral n))
          (m* (solutions.to-numeral m)))
      (= (op n m)
         (solutions.from-numeral (op-numerals m* n*))))))

(test-case
  "PROPERTY: Converting to a numeral and then back is the identity"
  (check-property from-to-id))

(test-case
  "PROPERTY: zero is left and right identity for plus"
  (check-property plus-zero-id))

(test-case
  "PROPERTY: plus is commutative"
  (check-property (oper-commut solutions.plus)))

(test-case
  "MODEL CHECK: plus behaves like +"
  (check-property (oper-model + solutions.plus)))

(test-case
  "UNIT TESTS: plus"
  (test-begin
    (check-equal? ((solutions.plus two (solutions.plus two twelve)) times2 1)
                  65536)
    (check-equal? ((solutions.plus two twelve) times2 1)
                  16384)))

(test-case
  "PROPERTY: one is left and right identity for mult"
  (check-property mult-one-id))

(test-case
  "PROPERTY: mult is commutative"
  (check-property (oper-commut solutions.mult)))

(test-case
  "MODEL CHECK: mult behaves like *"
  (check-property (oper-model * solutions.mult)))

(test-case
  "UNIT TESTS: mult"
  (test-begin
    (check-equal? ((solutions.mult two (solutions.mult two (solutions.mult two two))) times2 1)
                  65536)
    (check-equal? ((solutions.mult two ten) times2 1)
                  1048576)))

(test-case
  "(BONUS) UNIT TESTS: pred"
  (test-begin
    (check-equal? (solutions.from-numeral (solutions.pred zero))
                  0)
    (check-equal? (solutions.from-numeral (solutions.pred (solutions.to-numeral 70)))
                  69)))
