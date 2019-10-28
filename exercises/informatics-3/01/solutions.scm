(define (succ n) (+ n 1))
(define (pred n) (- n 1))

(define (add a b)
  (if (= b 0)
      a
      (succ (add a (pred b)))))

(define (multiply a b)
  (if (= b 0)
      0
      (add a (multiply a (pred b)))))

(define (fact n)
  (if (= n 0)
      1
      (multiply n (fact (pred n)))))

(define (safe-div n)
  ; find the largest number x such that x * 2 <= n
  (define (check x)
    (if (> (multiply 2 x) n)
        (check (pred x))
        x))
  (check n))

(define (fib n)
  (cond
      ((= n 0) 0)
      ((= n 1) 1)
      (else (add (fib (pred n)) (fib (pred (pred n)))))))

(define (ack n a b)
  ; see https://en.wikipedia.org/wiki/Ackermann_function for more information
  (cond
    ((= n 1) (add a b))
    ((= b 0)
        (cond
          ((= n 2) 0)
          ((= n 3) 1)
          (else a)))
    (else (ack (pred n) a (ack n a (pred b))))))


(display (ack 4 2 3))
