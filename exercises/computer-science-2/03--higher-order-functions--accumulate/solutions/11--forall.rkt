#lang racket
(require rackunit rackunit/text-ui)

(require "06--accumulate.rkt")

(define (1+ n) (+ 1 n))

; ### Задача 11
; Напишете функция `(forall? pred? a b)`,
; която проверява дали за всяко цяло число в интервала [a, b] предикатът `pred?` е истина.

(define (forall? pred? a b)
  (accumulate (lambda (x y) (and x y))
              #t
              a
              b
              pred?
              1+))

(run-tests (test-suite "forall? tests"
             (check-true (forall? even? 2 2))
             (check-true (forall? (lambda (n) (> n 10)) 11 190))
             ; Всеки елемент на празното множество удовлетворява каквото си искаме
             ; и интервалът от 5 до 1 е празното множество, защото 5 > 1.
             ; Тук каквото и да подадем на мястото на `procedure?`, трябва `forall?` да ни връща истина.
             (check-true (forall? procedure? 5 1))
             (check-false (forall? odd? 1 10))
             (check-false (forall? (lambda (n) (> n 10)) 10 190))
             (check-false (forall? (lambda (n) (< n 10)) 1 10)))
           'verbose)

