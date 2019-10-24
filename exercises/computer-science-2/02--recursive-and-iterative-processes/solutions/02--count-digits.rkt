#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 2
; Напишете функция `count-digits`, която намира броя цифри на дадено цяло число (което може да е отрицателно).

(define (count-digits-rec n)
  (if (< n 0)
      ; Функцията `-`, приложена само над един аргумент, сменя знака на аргумента.
      ; Тук ако n е отрицателно, връщаме функцията от -n.
      ; Така си подсигуряваме останалата логика да работи винаги над положителни числа.
      (count-digits-rec (- n))
      (if (< n 10)
          1
          (+ 1 (count-digits-rec (quotient n 10))))))

(define (count-digits-iter n)
  ; Тук просто си дефинираме функция на име `for`, това няма никакъв по-различен смисъл.
  ; Можеше да я кръстим по всякакъв начин, например `helper`, защото е помощна функция.
  ; Аз използвам конвенцията да кръщавам помощните функции `for`,
  ; ако ги ползвам за да реализирам итеративен процес.
  (define (for num result)
    (if (< num 10)
        ; Важно е тук да върнем нещо, зависещо от `result`, там ни е натрупан отговора.
        (+ 1 result)
        (for (quotient num 10) (+ 1 result))))

  ; Извикваме функцията, която дефинирахме вложено по-горе.
  ; Ако ги няма следващите 3 реда, извикването на `count-digits-iter` ще ни върне грешка,
  ; защото `count-digits-iter` не връща нищо.
  (if (< n 0)
      (for (- n) 0)
      (for n 0)))

; За да можем лесно да сменяме и оттам тестваме имплементациите.
;(define count-digits count-digits-rec)
(define count-digits count-digits-iter)

(run-tests (test-suite "count-digits tests"
                       (check-eq? (count-digits 12345) 5)
                       (check-eq? (count-digits 0) 1)
                       (check-eq? (count-digits -1009) 4)
                       (check-eq? (count-digits 1000000) 7))
           'verbose)

