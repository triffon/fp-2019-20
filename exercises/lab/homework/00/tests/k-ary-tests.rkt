#lang racket

(require quickcheck
         rackunit
         rackunit/quickcheck)

(require (prefix-in solutions. "../solutions/k-ary.rkt"))


(define from-to-id
  (property ((n (choose-integer 1 2147483561))
             (k (choose-integer 2 9)))
    (= n (solutions.from-k-ary (solutions.to-k-ary n k) k))))

(define (list-to-num xs)
  (foldl (lambda (x acc)
           (+ (* 10 acc) x))
         0
         xs))

(define to-from-id
  (property ((k (choose-integer 2 9)))
    (property ((ns (sized
                     (lambda (n) (choose-list (choose-integer 0 (- k 1)) n)))))
      (let ((m (list-to-num ns)))
        (= m (solutions.to-k-ary (solutions.from-k-ary m k) k))))))

(test-case
  "PROPERTY: Converting to k-ary and then from k-ary is the identity"
  (check-property from-to-id))

(test-case
  "PROPERTY: Converting from k-ary and then to k-ary is the identity"
  (check-property to-from-id))

(test-case
  "UNIT TESTS: to-k-ary"
  (test-begin
    (check-equal? (solutions.to-k-ary 2 5) 2)
    (check-equal? (solutions.to-k-ary 6 7) 6)
    (check-equal? (solutions.to-k-ary 0 9) 0)
    (check-equal? (solutions.to-k-ary 1234567123 6) 322301020311)
    (check-equal? (solutions.to-k-ary 83742878901 5) 2333001134111101)
    (check-equal? (solutions.to-k-ary 1438091 3) 2201001200122)))

(test-case
  "UNIT TESTS: from-k-ary"
  (test-begin
    (check-equal? (solutions.from-k-ary 0 7) 0)
    (check-equal? (solutions.from-k-ary 8 9) 8)
    (check-equal? (solutions.from-k-ary 2 3) 2)
    (check-equal? (solutions.from-k-ary 12312312301 6) 86058829)
    (check-equal? (solutions.from-k-ary 14321415 7) 1349913)
    (check-equal? (solutions.from-k-ary 143213001 5) 757251)))
