(define (drop n xs)
  (cond
    ((= n 0) xs)
    ((> n (length xs)) '())
    ((= n 1) (cdr xs))
    (else (drop (- n 1) (cdr xs)))))



(drop 0 '(2 9 2))
(drop 2134 '(9 7 2 3))
(drop 1 '(23 34 56))
(drop 2 '(1 2 3 4))
(drop 4 '(1 2 3 4 5 6 7 8 9))