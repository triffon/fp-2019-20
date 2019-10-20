#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 4
; Напишете функция `palindrome?`, която проверява дали дадено число е палиндром.
; Палиндром е число, което не се променя, ако обърнем реда на цифрите му.
; (Предизвикателство: реализирайте функцията без да ползвате `reverse-num`).

(define (palindrome? n) void)

(run-tests (test-suite "count-digits tests"
                       (check-false (palindrome? 1234))
                       (check-true (palindrome? 9102019))
                       (check-true (palindrome? 10000001)))
           'verbose)

