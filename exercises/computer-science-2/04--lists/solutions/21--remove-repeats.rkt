#lang racket
(require rackunit rackunit/text-ui)

; ### Задача 21
; Напишете функция `(remove-repeats L)`,
; която премахва последователните повторения на едно и също число от списъка `L`.

; Премахва всички срещания на `x` в началото `L`.
; Ако срещне нещо различно от `x`, спира работа.
(define (remove-from-beginning x L)
  (cond ((null? L) L)
        ((equal? x (car L)) (remove-from-beginning x (cdr L)))
        (else L)))
      

(define (remove-repeats L)
  (if (null? L)
      L
      (cons (car L)
            (remove-repeats (remove-from-beginning (car L) L)))))


(run-tests (test-suite "remove-repeats tests"
             (check-equal? (remove-repeats '())
                           '())
             (check-equal? (remove-repeats '(5))
                           '(5))
             (check-equal? (remove-repeats '(1 1 4 4 3 3 4 4 4))
                           '(1 4 3 4))
             (check-equal? (remove-repeats '(1 2 3 4))
                           '(1 2 3 4)))
           'verbose)

