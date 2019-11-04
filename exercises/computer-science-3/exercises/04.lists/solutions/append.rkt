(define (append2 xs ys)
 (if (null? xs) ys
    (cons (car xs) (append2 (cdr xs) ys))))


(append2 '() '(2 3))
(append2 '(2 3) '())
(append2 '(5 9 2) '(1))
(append '(1 8 6 2 3) '(2 3))