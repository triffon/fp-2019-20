(require rackunit rackunit/text-ui)

(define (sum l) (apply + l))

(define (prod l) (apply * l))

(define (count p l)
  (length (filter p l)))

(define (count-metrics ml ll)
  (count (lambda (m)
           (apply = (map m ll)))
         ml))

(define count-metrics-tests
  (test-suite
    "Tests for count-metrics"

    (check-equal? (count-metrics (list sum prod)
                                 '((0 1 2) (3 0 5) (1337 0)))
                  1)
    (check-equal? (count-metrics (list car sum)
                                 '((42 -2 2) (42 0) (42)))
                  2)))

(run-tests count-metrics-tests)
