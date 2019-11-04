(define (take n xs)
  (cond
    ((< n 0) "error")
    ((> n (length xs)) xs)
    ((= n 0) '())
    ((if (= n 1) (list (car xs))
         (append (list (car xs)) (take (- n 1) (cdr xs))))))) ; може да се напише (cons (car xs) (take ...))
 

(take 2134 '(9 7 2 3))
(take 0 '(2 9 2))
(take 2 '(1 2 3))
(take 3 '(1 2 3 4 5 6 7))