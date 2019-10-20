#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (count-digits-iter n)
  (define (for num result)
    (if (< num 10)
        (+ 1 result)
        (for (quotient num 10) (+ 1 result))))
  (if (< n 0)
      (for (- n) 0)
      (for n 0)))

(define (reverse-num-iter n)
  (define (for num result)
    (if (< num 10)
        (+ (* 10 result)
           num)
        (for (quotient num 10)
             (+ (* result 10)
                (remainder num 10)))))
  (if (< n 0)
      (- (for (- n) 0))
      (for n 0)))

; ### Задача 4
; Напишете функция `palindrome?`, която проверява дали дадено число е палиндром.
; Палиндром е число, което не се променя, ако обърнем реда на цифрите му.
; (Предизвикателство: реализирайте функцията без да ползвате `reverse-num`).

(define (palindrome?-1 n)
  (= n (reverse-num-iter n)))


(define (get-digit i n)
  (if (= i 1)
      (remainder n 10)
      (get-digit (- i 1) (quotient n 10))))

; Идеята за решение без `reverse-num` е:
; даденото ни `n` го ползваме като константа и не го променяме
; имаме два индекса `i` и `j`, които сочат към първата и последната непроверена цифра в `n`
; ако `i != j`, то числото не е палиндром, иначе правим рекурсивно извикване на следващите цифри
(define (palindrome?-2 n)
  ; Дефинираме си тази малка функция, за да не я пишем два пъти по-долу.
  (define (same-digits i j)
    (= (get-digit i n) (get-digit j n)))
  ; За да си ползваме `n` като константа, основната логика ще вкараме във вложена функция
  (define (helper i j)
    (cond ((= i j) #t)
          ((= i (+ 1 j)) (same-digits i j))
          ((same-digits i j) (helper (- i 1) (+ j 1)))
          (else #f)))

  (helper (count-digits-iter n) 1))


(define palindrome? palindrome?-2)

(run-tests (test-suite "count-digits tests"
                       (check-false (palindrome? 1234))
                       (check-true (palindrome? 9102019))
                       (check-true (palindrome? 10000001)))
           'verbose)

