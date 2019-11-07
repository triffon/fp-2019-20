(define (minimum l)
    (apply min l))

(define (take-while p l)
  (if (or (null? l)
          (not (p (car l))))
      '()
      (cons (car l)
            (take-while p (cdr l)))))

(define (drop-while p l)
  (if (or (null? l)
          (not (p (car l))))
      l
      (drop-while p (cdr l))))

(define (remove x l)
  (define (!=x y)
    (not (= y x)))

  (if (not (member x l))
      l
      (append (take-while !=x l)
              (cdr (drop-while !=x l)))))

(define (selection-sort l)
  (if (null? l)
      '()
      (let ((min-in-l (minimum l)))
        (cons min-in-l
              (selection-sort (remove min-in-l l))))))

(load "../testing/check.scm")

(check (selection-sort '()) => '())
(check (selection-sort '(42)) => '(42))
(check (selection-sort '(6 6 6)) => '(6 6 6))
(check (selection-sort '(1 2 3 4 5 6)) => '(1 2 3 4 5 6))
(check (selection-sort '(6 5 4 3 2 1)) => '(1 2 3 4 5 6))
(check (selection-sort '(3 1 4 6 2 5)) => '(1 2 3 4 5 6))
(check (selection-sort '(5 2 5 1 5 2 3)) => '(1 2 2 3 5 5 5))

(check-report)
(check-reset!)
