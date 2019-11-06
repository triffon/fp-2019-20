#lang racket
(require rackunit rackunit/text-ui)


; ### Задача 11
; Напишете функция `(partition pred? L)`,
; която връща списък от два списъка.
; Първият подсписък съдържа всички елементи на `L`, за които `pred?` е истина, а вторият съдържа всички, за които `pred?` е лъжа.

(define (partition p? L)
  (list (filter p? L)
        (filter (lambda (x)
                  (not (p? x)))
                L)))


(run-tests (test-suite "partition tests"
             (check-equal? (partition odd? '())
                           '(() ()))
             (check-equal? (partition even? '(2 2 2 2))
                           '((2 2 2 2) ()))
             (check-equal? (partition odd? '(2 2 2 2))
                           '(() (2 2 2 2)))
             (check-equal? (partition odd? '(1 2 3 4 5 6))
                           '((1 3 5) (2 4 6)))
             (check-equal? (partition pair? '(1 (2 3) 4 ((5)) 6))
                           '(((2 3) ((5))) (1 4 6)))
             (check-equal? (partition procedure? 
                                   (list 1 '(2 3) + 4 '((5)) 6 pair? partition))
                           (list (list + pair? partition)
                                 '(1 (2 3) 4 ((5)) 6))))
           'verbose)

