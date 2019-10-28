(load "./accumulate.scm")

; Можем да изразим процедурата count чрез сума от нули и единици. Идеята е да
; добавяме 1 за всяко цяло число, което удовлетворява predicate, и 0 за всяко
; цяло число, което не удовлетворява predicate.
(define (count predicate a b)
  (sum (lambda (a)
         (if (predicate a)
             1
             0))
       a
       (lambda (a) (+ a 1))
       b))

; Друг вариант: изразяваме count чрез натрупване на единици само за целите
; числа, които удовлетворяват predicate. Добавяме 1 към акумулатора (acc) само
; ако текущото цяло число от интервала (current) удовлетворява predicate, иначе
; не променяме acc.
(define (count predicate a b)
  (accumulate (lambda (current acc)
                (if (predicate current)
                    (+ acc 1)
                    acc))
              0
              (lambda (a) a)
              a
              (lambda (a) (+ a 1))
              b))

(load "../testing/check.scm")

(check (count even? 1 5) => 2)
(check (count even? 0 10) => 6)
(check (count odd? 1 5) => 3)
(check (count odd? 0 10) => 5)

(check-report)
(check-reset!)
