#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 5
; Напишете функция `prime?`, която проверява дали дадено цяло число е просто. Следното наблюдение може да е от полза:
; 
; > Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 включително (или от 2 до √n, ако ви се занимава).

; `x` дели `y`, ако остатъкът при деление `y` на `x` е 0
(define (divides? x y)
  (= (remainder y x) 0))

(define (prime?-1 n)
  (if (< n 2)
      #f
      ; Дефинираме променлива rootn = √n
      (let ((rootn (sqrt n)))
        ; `i` пробягва от 0 до √n
        (define (for i)
          (if (> i rootn)
              #t
              (if (divides? i n)
                  #f
                  (for (+ 1 i)))))
        (for 2))))

; Може и да дефинираме функцията с по-малко символи,
; като вместо `if` ползваме `or` и `and` и обърнем условията.
(define (prime?-2 n)
  (and (>= n 2)
       ; Дефинираме променлива rootn = √n
       (let ((rootn (sqrt n)))
         ; `i` пробягва от 0 до √n
         (define (for i)
           (or (> i rootn)
               (and (not (divides? i n))
                    (for (+ 1 i)))))
         (for 2))))

(define prime? prime?-1)


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

