(require rackunit rackunit/text-ui)

(define (square x) (* x x))
(define (cube x) (* x x x))

; Решението на тази задача се получава лесно, ако разсъждаваме
; за структурата на списъка l. Понеже той е изграден от
; произволно вложени наредени двойки, то всяка наредена двойка може да съдържа:
; 1) други наредени двойки или 2) атоми, например число или #t.
; Понеже l е по-специален случай, а именно списък от списъци,
; то дясната част на произволна наредена двойка може да бъде празният списък '().
;
; Можем да си мислим за наредената двойка като двоично дърво с два клона.
;
; Така можем да опишем всички 3 състояния на l:
; 1) '() - тук няма как да приложим f и просто връщаме '().
; 2) (cons left-pair right-pair) - прилагаме рекурсивно map-deep по двата клона.
; 3) (cons atom right-pair) - atom не е наредена двойка и прилагаме f над atom.
;
; Описваме решението си едно към едно... само, че на Scheme.
(define (map-deep f l)
  (cond ((null? l) '())
        ((pair? (car l)) (cons (map-deep f (car l))
                               (map-deep f (cdr l))))
        (else (cons (f (car l))
                    (map-deep f (cdr l))))))

(define map-deep-tests
  (test-suite
    "Tests for map-deep"

    (check-equal? (map-deep cube '())
                  '())
    (check-equal? (map-deep square '((1 2 (3 4)) 5))
                  '((1 4 (9 16)) 25))
    (check-equal? (map-deep square '((((2)) 1 ((4) 3)) (9)))
                  '((((4)) 1 ((16) 9)) (81)))
    (check-equal? (map-deep cube '(3 2 ((3) 4)))
                  '(27 8 ((27) 64)))))

(run-tests map-deep-tests)
