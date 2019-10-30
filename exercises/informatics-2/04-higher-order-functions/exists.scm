(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

; Тъй като or е специална форма (макро), не можем да подадем or директно като
; аргумент на accumulate. Затова използваме lambda, която изпълнява or над
; двата си аргумента. При това решение винаги минаваме през целия интервал
; [a, b], независимо дали преди края му има елемент, удовлетворяващ predicate.
(define (exists? predicate a b)
  (accumulate (lambda (x y) (or x y)) #f
              predicate
              a (lambda (x) (+ x 1)) b))

; По-ефикасно решение, тъй като or е специална форма и
; при първото срещане на число, което удовлетворява predicate,
; изчислението ще бъде прекъснато и ще получим #t.
(define (exists? predicate a b)
  (and (<= a b)
       (or (predicate a)
           (exists? predicate (+ a 1) b))))

(define exists?-tests
  (test-suite
    "Tests for exists?"

    (check-true (exists? (lambda (x) (= x 3)) 1 5))
    (check-true (exists? (lambda (x) (< x 0)) -3 9))
    (check-true (exists? (lambda (x) (= 0 (* x 0))) -3 15))

    (check-false (exists? (lambda (x) (= x 13)) 1 5))
    (check-false (exists? (lambda (x) (< x 3)) 10 42))
    (check-false (exists? (lambda (x) (< x 0)) 3 8))
    (check-false (exists? (lambda (x) (= 0 (* x 0))) 2 1))))

(run-tests exists?-tests)
