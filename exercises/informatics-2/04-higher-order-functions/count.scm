(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

(define (inc x) (+ x 1))

; Идеята е да добавяме 1 за всеки елемент, който удовлетворява predicate, и
; 0 за всеки елемент, който не удовлетворява predicate.
(define (count predicate a b)
  (accumulate + 0
              (lambda (x) (if (predicate x) 1 0))
              a inc b))

; Друг вариант: добавяме 1 към крайния резултат (acc) само ако текущият
; елемент от интервала удовлетворява predicate.
(define (count predicate a b)
  (accumulate (lambda (x acc) (if (predicate x) (+ acc 1) acc)) 0
              (lambda (x) x)
              a inc b))

(define count-tests
  (test-suite
    "Tests for count"

    (check = (count even? 1 5) 2)
    (check = (count even? 0 10) 6)

    (check = (count odd? 1 5) 3)
    (check = (count odd? 0 10) 5)))

(run-tests count-tests)
