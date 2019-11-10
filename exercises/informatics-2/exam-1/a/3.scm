(require rackunit rackunit/text-ui)

(define (repeat n x)
  (if (= n 0)
      '()
      (cons x (repeat (- n 1) x))))

(define (deep-repeat-help l level)
  (cond ((null? l) '())
        ((pair? (car l)) (cons (deep-repeat-help (car l) (+ level 1))
                               (deep-repeat-help (cdr l) level)))
        (else (append (repeat level (car l))
                      (deep-repeat-help (cdr l) level)))))

(define (deep-repeat l)
  (deep-repeat-help l 1))

(define max-metric-tests
  (test-suite
    "Tests for max-metric"

    (check-equal? (deep-repeat '(1 (2 3) 4 (5 (6))))
                               '(1 (2 2 3 3) 4 (5 5 (6 6 6))))))

(run-tests max-metric-tests)
