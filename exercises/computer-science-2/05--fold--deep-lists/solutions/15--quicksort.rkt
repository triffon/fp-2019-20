(define (quicksort l)
  (if (or (null? l) (null? (cdr l)))
      l
      (let ((pivot (car l)))
        (append
          (quicksort (filter (lambda (x) (<= x pivot)) (cdr l)))
          (list pivot)
          (quicksort (filter (lambda (x) (> x pivot)) l))))))
