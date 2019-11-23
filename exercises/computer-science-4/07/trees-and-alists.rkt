#lang racket

; Двоично дърво ще представяме по следния начин:
; 1) '() е двоично дърво.
; 2) (root left right) е двоично дърво, точно когато
;   left и right са двоични дървета, а root е просто стойността в корена.

; Нека си дефинираме няколко функции за работа с двоични дървета

; Проверяваме по дефиницията
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))

(define root car)

(define left cadr)

(define right caddr)

(define (make-tree root left right)
  (list root left right))

(define empty? null?)

; Едно дърво е листо ако има вида (root '() '()),
; тоест текущия връх няма наследници
(define (leaf? t)
  (and (empty? (left t))
       (empty? (right t))))


; Пример:
;   1
;  / \
; 2   3
;      \
;       4
;
; Бихме го записали:
'(1 (2 () ())
    (3 ()
       (4 () ())))


; Имплементирайте следните функции за двоични дървета:

; Намира броя на листата в tree.
(define (count-leaves tree) void)

; Връща ново дърво, в което f е приложена над всеки връх от tree.
(define (map-tree f tree) void)

; Връща списък от всички върхове на разстояние n от корена на tree.
(define (level n tree) void)

; Обхождане на дърво, функциите да връщат списък от върховете в реда на обхождането им

; корен-ляво-дясно
(define (pre-order t) void)

; ляво-корен-дясно
(define (in-order t) void)

; ляво-дясно-корен
(define (post-order t) void)

