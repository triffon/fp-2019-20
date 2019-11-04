(define (take n xs)
  (cond
    ((< n 0) "error")
    ((> n (length xs)) xs)
    ((= n 0) '())
    ((if (= n 1) (list (car xs))
         (append (list (car xs)) (take (- n 1) (cdr xs)))))))

(define (drop n xs)
  (cond
    ((= n 0) xs)
    ((> n (length xs)) '())
    ((= n 1) (cdr xs))
    (else (drop (- n 1) (cdr xs)))))

(define (slice xs start end)
  (take (- end start -1) (drop start xs))) ; лудница


(slice '(1 9 8 2) 1 2)
(slice '(1 9 2 8 3) 2 10)
(slice '(9 7 2 3) 0 2)