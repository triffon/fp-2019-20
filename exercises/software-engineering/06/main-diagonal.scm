(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (map-with-index fn l)
  (map fn l (enumerate-interval 0 (- (length l) 1))))

(define (main-diagonal matrix)
  (map-with-index (lambda (row i)
                    (list-ref row i))
                  matrix))

(load "../testing/check.scm")

(check (main-diagonal '((1))) => '(1))
(check (main-diagonal '((1 2) (3 4))) => '(1 4))
(check (main-diagonal '((1 2 3) (4 5 6) (7 8 9))) => '(1 5 9))

(check-report)
(check-reset!)
