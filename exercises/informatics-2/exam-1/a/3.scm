(require rackunit rackunit/text-ui)

(define (repeat n x)
  (if (= n 0)
      '()
      (cons x (repeat (- n 1) x))))

(define (deep-repeat-help l level)
  (cond ((null? l) '())
        ((null? (car l)) (cons '() (deep-repeat-help (cdr l) level))) ; corner case
        ((pair? (car l)) (cons (deep-repeat-help (car l) (+ level 1))
                               (deep-repeat-help (cdr l) level)))
        (else (append (repeat level (car l))
                      (deep-repeat-help (cdr l) level)))))

(define (deep-repeat l)
  (deep-repeat-help l 1))

(define deep-repeat-tests
  (test-suite
    "Tests for deep-repeat"

    (check-equal? (deep-repeat '())
                               '())
    (check-equal? (deep-repeat '(((())))) ; tricky corner case
                               '(((()))))
    (check-equal? (deep-repeat '(((6))))
                               '(((6 6 6))))
    (check-equal? (deep-repeat '((2 3) 4 ((6))))
                               '((2 2 3 3) 4 ((6 6 6))))
    (check-equal? (deep-repeat '(1 (2 3) 4 (5 (6))))
                               '(1 (2 2 3 3) 4 (5 5 (6 6 6))))))

(run-tests deep-repeat-tests)
