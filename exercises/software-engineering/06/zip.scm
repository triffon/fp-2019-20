(define (zip x y)
  (if (or (null? x)
          (null? y))
      '()
      (cons (list (car x) (car y))
            (zip (cdr x) (cdr y)))))

(define (zip-with fn x y)
  (if (or (null? x)
          (null? y))
      '()
      (cons (fn (car x) (car y))
            (zip-with fn (cdr x) (cdr y)))))

; zip е частен случай на zip-with
(define (zip x y)
  (zip-with list x y))

(define (any? p l)
  (and (not (null? l))
       (or (p (car l))
           (any? p (cdr l)))))

(define (zip-with* fn . ls)
  (if (or (null? ls)
          (any? null? ls))
      '()
      (cons (apply fn (map car ls))
            (apply zip-with* fn (map cdr ls)))))

(load "../testing/check.scm")

(check (zip '() '()) => '())
(check (zip '(42) '()) => '())
(check (zip '(1 3 5) '(2 4 6)) => '((1 2) (3 4) (5 6)))
(check (zip '(1 3 5) '(2 4 6 8)) => '((1 2) (3 4) (5 6)))

(check (zip-with + '() '()) => '())
(check (zip-with + '(42) '()) => '())
(check (zip-with + '(1 3 5) '(2 4 6)) => '(3 7 11))
(check (zip-with + '(1 3 5) '(2 4 6 8)) => '(3 7 11))

(check (zip-with* + '() '() '()) => '())
(check (zip-with* + '(42) '() '(1 2 3)) => '())
(check (zip-with* + '(1 2 3) '(4 5 6) '(7 8 9)) => '(12 15 18))
(check (zip-with* cons '(1 3 5) '(2 4 6 8 10)) => '((1 . 2) (3 . 4) (5 . 6)))

(check-report)
(check-reset!)
