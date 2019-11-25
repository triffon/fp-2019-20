(load "./nth-column.scm")

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (transpose matrix)
  (define number-of-columns (length (car matrix)))

  (map (lambda (column-index)
         (nth-column matrix column-index))
       (enumerate-interval 0 (- number-of-columns 1))))

; Друго решение: използваме map с произволен брой списъци
(define (transpose matrix)
  (apply map list matrix))

(load "../testing/check.scm")

(check (transpose '((1))) => '((1)))
(check (transpose '((1) (2))) => '((1 2)))
(check (transpose '((1 2 3))) => '((1) (2) (3)))
(check (transpose '((1 2 3) (4 5 6))) => '((1 4) (2 5) (3 6)))
(check (transpose '((1 2 3) (4 5 6) (7 8 9))) => '((1 4 7) (2 5 8) (3 6 9)))

(check-report)
(check-reset!)
