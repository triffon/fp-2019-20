(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

; Тъй като and е специална форма (макро), не можем да подадем and директно като
; аргумент на accumulate. Затова използваме lambda, която изпълнява and над
; двата си аргумента. При това решение винаги минаваме през целия интервал
; [a, b], независимо дали преди края му има елемент, неудовлетворяващ predicate.
(define (for-all? predicate a b)
  (accumulate (lambda (x y) (and x y)) #t
              predicate
              a (lambda (x) (+ x 1)) b))

; По-ефикасно решение, тъй като and е специална форма и
; при първото срещане на число, което не удовлетворява predicate,
; изчислението ще бъде прекъснато и ще получим #f.
(define (for-all? predicate a b)
  (or (> a b)
      (and (predicate a)
           (for-all? predicate (+ a 1) b))))

(define (exists? predicate a b)
  (and (<= a b)
       (or (predicate a)
           (exists? predicate (+ a 1) b))))

; Имплементация на for-all? чрез exists?. Аналогично, ако имаме for-all?,
; можем да имплементираме exists? чрез for-all?.
(define (for-all? predicate a b)
  (not (exists? (lambda (x) (not (predicate x))) a b)))

(define for-all?-tests
  (test-suite
    "Tests for for-all?"

    (check-true (for-all? (lambda (x) (> x 0)) 2 98))
    (check-true (for-all? (lambda (x) (< x 0)) -10 -1))
    (check-true (for-all? (lambda (x) (= 0 (* x 0))) -3 15))
    (check-true (for-all? (lambda (x) (= 0 (* x 1))) 2 1))

    (check-false (for-all? (lambda (x) (= x 3)) 1 5))
    (check-false (for-all? (lambda (x) (= x 13)) 1 5))
    (check-false (for-all? (lambda (x) (< x 3)) -5 42))))

(run-tests for-all?-tests)
