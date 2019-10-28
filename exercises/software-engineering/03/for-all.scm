(load "./accumulate.scm")
(load "./exists.scm")

; Тъй като and е специална форма, не можем да подадем and директно като аргумент
; на accumulate. Затова използваме lambda, която изпълнява and над двата си
; аргумента. При това решение винаги минаваме през целия интервал [a, b],
; независимо дали преди края му има цяло число, неудовлетворяващо predicate.
(define (for-all? predicate a b)
  (accumulate (lambda (current acc)
                (and current acc))
              #t
              predicate
              a
              (lambda (a) (+ a 1))
              b))

; По-ефикасно решение, тъй като and е специална форма и след първото срещане на
; цяло число n, което не удовлетворява predicate, няма да бъде разгледан
; подинтервала [n + 1, b].
(define (for-all? predicate a b)
  (or (> a b)
      (and (predicate a)
           (for-all? predicate (+ a 1) b))))

; Имплементация на for-all? чрез exists?. Аналогично, ако имаме for-all?, можем
; да имплементираме exists? чрез for-all?.
(define (for-all? predicate a b)
  (not (exists? (lambda (a)
                  (not (predicate a)))
                a
                b)))

(load "../testing/check.scm")

(check (for-all? (lambda (x) (> x 0)) 2 98) => #t)
(check (for-all? (lambda (x) (< x 0)) -10 -1) => #t)
(check (for-all? (lambda (x) (= 0 (* x 0))) -3 15) => #t)
(check (for-all? (lambda (x) (= 0 (* x 1))) 2 1) => #t)

(check (for-all? (lambda (x) (= x 3)) 1 5) => #f)
(check (for-all? (lambda (x) (= x 13)) 1 5) => #f)
(check (for-all? (lambda (x) (< x 3)) -5 42) => #f)

(check-report)
(check-reset!)
