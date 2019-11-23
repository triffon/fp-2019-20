(load "./add-last.scm")

(define (reverse l)
  (if (null? l)
      '()
      (add-last (reverse (cdr l))
                (car l))))

; Решение с линейна итерация
(define (reverse l)
  (define (iter reversed l)
    (if (null? l)
        reversed
        (iter (cons (car l) reversed)
              (cdr l))))

  (iter '() l))

(load "../testing/check.scm")

(check (reverse '()) => '())
(check (reverse '(42)) => '(42))
(check (reverse '(1 2)) => '(2 1))
(check (reverse '(1 2 3 4 5 6)) => '(6 5 4 3 2 1))
(check (reverse '(4 3 3 2 5 2)) => '(2 5 2 3 3 4))
(check (reverse '(1 2 3 2 1)) => '(1 2 3 2 1))

(check-report)
(check-reset!)
