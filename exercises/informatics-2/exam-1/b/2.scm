(require rackunit rackunit/text-ui)

(define (sum l) (apply + l))

(define (prod l) (apply * l))

(define (identity x) x)

(define (for-all? p? l)
  (foldl (lambda (x acc) (and (p? x) acc)) #t l))

(define (exists? p? l)
  (not (for-all? (lambda (x) (not (p? x))) l)))

(define (without x l)
  (filter (lambda (y) (not (equal? y x))) l))

(define (>* l1 l2)
  (for-all? identity (map > l1 l2)))

(define (best-metric? ml ll)
  (exists? (lambda (best)
             (for-all? (lambda (m)
                         (>* (map best ll) (map m ll)))
                       (without best ml)))
           ml))

(define best-metric?-tests
  (test-suite
    "Tests for best-metric?"

    (check-equal? (best-metric? (list sum prod)
                                '((0 1 2) (3 -4 5) (1337 0)))
                  #t)
    (check-equal? (best-metric? (list car sum)
                                '((100 -100) (29 1) (42)))
                  #f)))

(run-tests best-metric?-tests)
