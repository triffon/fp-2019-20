#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 5
; Напишете функция `prime?`, която проверява дали дадено цяло число е просто. Следното наблюдение може да е от полза:
; 
; > Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 включително (или от 2 до √n, ако ви се занимава).

(define (prime? n) void)

(run-tests (test-suite "count-digits tests"
                       (check-false (prime? 0))
                       (check-false (prime? 1))
                       (check-false (prime? -120))
                       (check-false (prime? 120))
                       (check-true (prime? 2))
                       (check-true (prime? 3))
                       (check-true (prime? 7))
                       (check-true (prime? 101))
                       (check-true (prime? 2411)))
           'verbose)

