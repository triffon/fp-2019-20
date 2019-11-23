(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (any? p l)
  (and (not (null? l))
       (or (p (car l))
           (any? p (cdr l)))))

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

; Друг начин за дефиниране на any? - чрез every?.
(define (any? p l)
  (not (every? (compose not p) l)))

(define (meet-twice? f g a b)
  (define interval (enumerate-interval a b))

  (any? (lambda (x)
          (any? (lambda (y)
                  (and (not (= x y))
                       (= (f x) (g x))
                       (= (f y) (g y))))
                interval))
        interval))

(load "../testing/check.scm")

(check (meet-twice? (lambda (x) x) (lambda (x) x) 0 5) => #t)
(check (meet-twice? (lambda (x) x) sqrt 0 5) => #t)
(check (meet-twice? (lambda (x) x) (lambda (x) x) 42 42) => #f)
(check (meet-twice? (lambda (x) x) (lambda (x) (- x)) -3 1) => #f)

(check-report)
(check-reset!)
