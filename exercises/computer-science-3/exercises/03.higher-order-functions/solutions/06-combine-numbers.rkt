#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията, която ще напишете, очаква за вход две цели положителни числа, кръстени за по-удобно "first" и "second", и бинарна функция.
; Ако f1,f2,f3,...,fk и s1,s2,s3,...,sl са цифрите на съответните числа, а g е нашата бинарна функция, търсим резултатът от g(f1,s1) + g(f2,s2) + g(f3,s3) + ...
; Функцията да терминира при достигане края на едно от числата.

(define (combine-numbers first second g)
  ; тази и долната функция правят окей неща, но може да стане и по-просто
  ; няма нужда да започваме от първата цифра и на двете числа и да продължаваме нататък
  ; спокойно може да започнем отзад напред
  ; как взимаме последната цифра? (remainder x 10)
  ; как взимаме всички без последната? (quotient x 10)
  (define (first-digit number)
    (if (= (quotient number 10) 0)
        number
        (first-digit (quotient number 10))))
  
  (define (remove-first-digit number)
    (define (remove number power)
      (if (= (quotient number 10) 0)
          0
          (+ (* (remainder number 10) power) (remove (quotient number 10) (* power 10)))))

    (remove number 1)
   )

  (if (or (= first 0) (= second 0))
      0
      (+ (g (first-digit first) (first-digit second))  (combine-numbers (remove-first-digit first) (remove-first-digit second) g)))
)

; Бонус занимавка: Да параметризираме и операцията, с която комбинираме резултатите от g(fk,sl).
; В горната функция сме я забили на "+".


(define tests
  (test-suite "Combine numbers tests"
      ; Защото (remainder k k) = 0
      (check-equal? (combine-numbers 123 123 remainder) 0)
      ; Защото (4 * 9) + (2 * 8) = 52
      (check-equal? (combine-numbers 421384 98 *) 52)
      ; Защото (1 < 7) -> 1, (2 = 2) -> 0, (5 > 3) -> 0, (9 = 9) -> 0, (3 < 7) -> 1
      (check-equal? (combine-numbers 12593 72397 (lambda (x y) (if (< x y) 1 0))) 2)
      ; Като горния тест, но с по-късо второ число.
      (check-equal? (combine-numbers 2713 98 (lambda (x y) (if (< x y) 1 0))) 2)
      ; Като горния тест, но с по-късо първо число.
      (check-equal? (combine-numbers 213 91423 (lambda (x y) (if (< x y) 1 0))) 2)
  )
)

(run-tests tests 'verbose)
