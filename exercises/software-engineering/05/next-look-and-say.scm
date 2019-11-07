(define (take-while p l)
  (if (or (null? l)
          (not (p (car l))))
      '()
      (cons (car l)
            (take-while p (cdr l)))))

(define (drop-while p l)
  (if (or (null? l)
          (not (p (car l))))
      l
      (drop-while p (cdr l))))

(define (next-look-and-say y)
  (define (take-first-equals l)
    (take-while (lambda (x)
                  (= x (car l)))
                l))

  (define (drop-first-equals l)
    (drop-while (lambda (x)
                  (= x (car l)))
                l))

  (if (null? y)
      '()
      (cons (length (take-first-equals y))
            (cons (car y)
                  (next-look-and-say (drop-first-equals y))))))

(load "../testing/check.scm")

(check (next-look-and-say '()) => '())
(check (next-look-and-say '(1)) => '(1 1))
(check (next-look-and-say '(1 1 2 3 3)) => '(2 1 1 2 2 3))
(check (next-look-and-say '(1 1 2 2 3 3 3 3)) => '(2 1 2 2 4 3))

(check-report)
(check-reset!)
