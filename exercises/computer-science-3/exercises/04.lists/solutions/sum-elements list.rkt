(define (sum-elements xs)
  (if (null? xs) 0
      (+ (car xs) (sum-elements (cdr xs)))))

(sum-elements '(1 6))
(sum-elements '(-2 3 -1))

;iterative
(define (sum-elements xs)
  (define (sum-elements2 xs result)
    (if (null? xs) result
      (sum-elements2 (cdr xs) (+ (car xs) result))))
  (sum-elements2 xs 0))

(sum-elements '(1 6))
(sum-elements '(1 9))