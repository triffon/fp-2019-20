(define (deep-repeat l)
  (define (repeat x n)
    (if (= n 0)
        '()
        (cons x
              (repeat x (- n 1)))))

  (define (helper level l)
    (cond ((null? l) '())
          ((list? (car l))
           (cons (helper (+ level 1) (car l))
                 (helper level (cdr l))))
          (else (append (repeat (car l) level)
                        (helper level (cdr l))))))

  (helper 1 l))

(load "../../../testing/check.scm")

(check (deep-repeat '()) => '())
(check (deep-repeat '(1)) => '(1))
(check (deep-repeat '(1 2 3)) => '(1 2 3))
(check (deep-repeat '(1 (2) 3)) => '(1 (2 2) 3))
(check (deep-repeat '(1 () ((2 2 ())) 3)) => '(1 () ((2 2 2 2 2 2 ())) 3))
(check (deep-repeat '(1 (2 3) 4 (5 (6)))) => '(1 (2 2 3 3) 4 (5 5 (6 6 6))))

(check-report)
(check-reset!)
