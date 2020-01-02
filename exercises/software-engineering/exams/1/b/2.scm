(define (filter p l)
  (cond ((null? l) '())
        ((p (car l)) (cons (car l)
                     (filter p (cdr l))))
        (else (filter p (cdr l)))))

(define (all? p l)
  (or (null? l)
      (and (p (car l))
           (all? p (cdr l)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (any? p l)
  (not (all? (compose not p) l)))

(define (best-metric? ml ll)
  (define (better-than-others? metric)
    (define (better-than? other-metric)
      (all? (lambda (l)
              (> (metric l) (other-metric l)))
            ll))

    (define others (filter (lambda (other-metric)
                             (not (equal? metric other-metric)))
                           ml))

    (all? better-than? others))

  (any? better-than-others? ml))

(load "../../../testing/check.scm")

(define (sum l) (apply + l))
(define (prod l) (apply * l))

(check (best-metric? (list sum) '()) => #t)
(check (best-metric? (list sum) '((0 1 2) (3 4 5) (1337 0))) => #t)
(check (best-metric? (list sum prod) '((0 1 2) (3 4 5) (1337 0))) => #f)
(check (best-metric? (list car prod) '((29 1))) => #f)
(check (best-metric? (list car sum prod) '((1000 -1000) (29 1) (42))) => #f)
(check (best-metric? (list car sum prod) '((1000 1000) (29 2) (42 2))) => #t)
(check (best-metric? (list sum prod) '((0 1 2) (3 -4 5) (1337 0))) => #t)
(check (best-metric? (list car sum) '((100 -100) (29 1) (42))) => #f)

(check-report)
(check-reset!)
