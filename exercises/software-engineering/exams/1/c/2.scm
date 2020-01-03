(define (filter p l)
  (cond ((null? l) '())
        ((p (car l)) (cons (car l)
                     (filter p (cdr l))))
        (else (filter p (cdr l)))))

(define (all? p l)
  (or (null? l)
      (and (p (car l))
           (all? p (cdr l)))))

(define (has-equal-elements? l)
  (or (null? l)
      (all? (lambda (x)
              (equal? x (car l)))
            (cdr l))))

(define (count-metrics ml ll)
  (length (filter (lambda (metric)
                    (has-equal-elements? (map metric ll)))
                  ml)))

(load "../../../testing/check.scm")

(define (sum l) (apply + l))
(define (prod l) (apply * l))

(check (count-metrics (list sum) '()) => 1)
(check (count-metrics (list car sum prod) '()) => 3)
(check (count-metrics (list car prod) '((29 1))) => 2)
(check (count-metrics (list sum) '((0 1 2) (3 4 5) (1337 0))) => 0)
(check (count-metrics (list sum prod) '((0 1 2) (3 4 5) (1337 0))) => 0)
(check (count-metrics (list sum) '((0 1 2) (3 0 0) (1 0 2))) => 1)
(check (count-metrics (list sum prod car) '((0 1 2) (3 0 5) (1337 0))) => 1)
(check (count-metrics (list car sum prod) '((42 -2 2) (42 0) (42))) => 2)

(check-report)
(check-reset!)
