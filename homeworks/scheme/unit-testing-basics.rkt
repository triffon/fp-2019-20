#lang racket
(require rackunit rackunit/text-ui)
; Как да тестваме задачите си с rackunit:
; 1. Прочитаме условието на задачата
; 2. Мислим какво поведение трябва да има функцията, която се изисква
; 3. Разписваме си няколко сценария от типа "ако извикам функцията с x, очаквам тя да върне y"
; (може да опишем и свойство, което функцията ни очакваме да изпълнява, така че проверката да стане по-обща и да покрие повече случаи.
; Виж https://docs.racket-lang.org/quickcheck/index.html)
; 4. Тези сценарии може да пренесем директно в unit tests
; 5. Ако за пръв път разбираме за съществуването на unit tests, се образоваме по въпроса
; 6. Следващите фрагменти код показват как бихме тествали няколко функции, първо минавайки през горните 5 стъпки

(define (length xs)
  (void)
)

(define length-tests
  (test-suite "Length tests"
  ; test-suite групира всичките ни test-cases (напр. сценариите от типа "ако извикам функцията с x, очаквам тя да върне y)
  ; приема две неща: Име на групата тестове и множество test-cases.
    (test-case "should return 0 for empty list" (check-eq? (length '()) 0))
    ; test-case описва сценарий. Отново има име. Следват множество проверки.
    ; https://docs.racket-lang.org/rackunit/api.html#%28part._.Checks%29 - документация за видовете проверки
    (test-case "should return the length of a list if it's not empty" (check-eq? (length '(1 2)) 2))
  )
)

(run-tests length-tests 'verbose)
; така пускаме test-suite-а от горе.

(define (any? p? xs)
  (void)
)

(define any-tests
  (test-suite "Any tests"
    (test-case "Should return false for any predicate and the empty list"
               (check-false (any? (lambda (x) #t) '())))
    (test-case "Should return true if any element satisfies the given predicate"
               (check-true (any? (lambda (x) (= x 1)) '(1 2 3))))
    (test-case "Should return false if no elements satisfy the given predicate"
               (check-false (any? (lambda (x) (> x 10)) '(1 2 3))))
  )
)

(run-tests any-tests 'verbose)

; 7. След написаните тестове, започваме да решаваме съответната задача
; 8. Считаме задачата за решена, ако всички тестове минават (затова пишем тестовете си съвестно)
; 9. ???
; 10. profit.
