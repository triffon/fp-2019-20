(load "./accumulate.scm")

; Тъй като or е специална форма, не можем да подадем or директно като аргумент
; на accumulate. Затова използваме lambda, която изпълнява or над двата си
; аргумента. При това решение винаги минаваме през целия интервал [a, b],
; независимо дали преди края му има цяло число, удовлетворяващо predicate.
(define (exists? predicate a b)
  (accumulate (lambda (current acc)
                (or current acc))
              #f
              predicate
              a
              (lambda (a) (+ a 1))
              b))

; По-ефикасно решение, тъй като or е специална форма и след първото срещане на
; цяло число n, което удовлетворява predicate, няма да бъде разгледан
; подинтервала [n + 1, b].
(define (exists? predicate a b)
  (and (<= a b)
       (or (predicate a)
           (exists? predicate (+ a 1) b))))

(load "../testing/check.scm")

(check (exists? (lambda (x) (= x 3)) 1 5) => #t)
(check (exists? (lambda (x) (< x 0)) -3 9) => #t)
(check (exists? (lambda (x) (= 0 (* x 0))) -3 15) => #t)

(check (exists? (lambda (x) (= x 13)) 1 5) => #f)
(check (exists? (lambda (x) (< x 3)) 10 42) => #f)
(check (exists? (lambda (x) (< x 0)) 3 8) => #f)
(check (exists? (lambda (x) (= 0 (* x 0))) 2 1) => #f)

(check-report)
(check-reset!)
