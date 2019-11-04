(define (reverse2 xs)
  (if (or (null? xs) (= (length xs) 1)) xs
      (append (reverse2 (cdr xs)) (list (car xs)))))

(reverse2 '())
(reverse2 '(1))
(reverse2 '(1 2 3))
(reverse2 '(1 5))
(reverse2 '(23 34 56 69 2))


;iterative
(define (reverse2-iter xs)
  (define (reverse3 xs result)
    (if (or (null? xs) (= (length xs) 1)) (append xs result)
      (reverse3 (cdr xs) (append (list (car xs)) result))))
  (reverse3 xs '()))

(reverse2-iter '())
(reverse2-iter '(1))
(reverse2-iter '(1 2 3))
(reverse2-iter '(1 5))
(reverse2-iter '(23 34 56 69 2))


