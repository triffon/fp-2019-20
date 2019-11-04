(define (my-length xs)
  (if (null? xs) 0
      (+ 1 (my-length (cdr xs)))))

(my-length '(1 2))
(my-length '())

;iterative
(define (my-length xs)
  (define (my-length2 xs result)
    (if (null? xs) result
      (my-length2 (cdr xs) (+ 1 result))))
  (my-length2 xs 0))

(my-length '(1 2))
  