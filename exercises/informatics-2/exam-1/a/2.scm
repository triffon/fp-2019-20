(require rackunit rackunit/text-ui)

(define (prod l) (apply * l))
(define (sum l) (apply + l))

(define (maximum-by comp l)
  (foldl (lambda (x max)
           (if (> (comp x) (comp max))
               x
               max))
         (car l)
         (cdr l)))

(define (max-metric ml ll)
  (maximum-by (lambda (m)
                (sum (map (lambda (l) (m l)) ll)))
              ml))

(define max-metric-tests
  (test-suite
    "Tests for max-metric"

    (check-equal? (max-metric (list sum prod)
                              '((0 1 2) (3 4 5) (1337 0)))
                  sum)
    (check-equal? (max-metric (list car sum)
                              '((1000 -1000) (29 1) (42)))
                  car)))

(run-tests max-metric-tests)
