(define (foldr operation null-value l)
  (if (null? l)
      null-value
      (operation (car l)
                 (foldr operation null-value (cdr l)))))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (flatmap f l)
  (foldr append '() (map f l)))

(define (prime? n)
  (define (count-divisors n)
    (define (divides? k n)
      (= (remainder n k) 0))

    (define (divisors-up-to k)
      (cond ((= k 0) 0)
            ((divides? k n)
             (+ 1 (divisors-up-to (- k 1))))
            (else (divisors-up-to (- k 1)))))

    (divisors-up-to n))

  (= (count-divisors n) 2))

(define (prime-sum-pairs n)
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

  (define pairs
    (flatmap (lambda (i)
               (map (lambda (j) (list i j))
                    (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

  (map make-pair-sum
       (filter prime-sum? pairs)))

(load "../testing/check.scm")

(check (prime-sum-pairs 1) => '())
(check (prime-sum-pairs 2) => '((2 1 3)))
(check (prime-sum-pairs 6) => '((2 1 3)
                                (3 2 5)
                                (4 1 5)
                                (4 3 7)
                                (5 2 7)
                                (6 1 7)
                                (6 5 11)))

(check-report)
(check-reset!)
