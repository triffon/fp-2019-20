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

; ### Задача 3
; Напишете функция `reverse-num`, която обръща реда на цифрите на дадено число.

(define (reverse-num-rec n)
  (if (< n 0)
      ; Ако n е отрицателно, обръщаме цифрите на положителното му число
      ; и след това пак го правим отрицателно.
      (- (reverse-num-rec (- n)))
      (if (< n 10)
          n
          (+ (* (remainder n 10)
                (expt 10 (- (count-digits-iter n) 1)))
             (reverse-num-rec (quotient n 10))))))

(define (reverse-num-iter n)
  ; Тук допускаме, че `num` е положително.
  ; Когато извикваме `for` на ред 38 ще се погрижим за отрицателния случай.
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


(define reverse-num reverse-num-iter)

(run-tests (test-suite "reverse-num tests"
                       (check-eq? (reverse-num 12305) 50321)
                       (check-eq? (reverse-num 10000) 1)
                       (check-eq? (reverse-num -1093) -3901)
                       (check-eq? (reverse-num 10000001) 10000001))
           'verbose)

