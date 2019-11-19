#lang racket

; Двоично дърво представяме като списък от 3 елемента - корен, ляво и дясно поддърво.
; '(<root> <left> <right>)

; За да не повтаряме едни и същи конструкции и за да е по-четим кода
; ще си дефинираме функции за работа двоични дървета

(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))

(define root car)

(define left cadr)

(define right caddr)

(define empty? null?)

(define (leaf? t)
  (and (empty? (left t))
       (empty? (right t))))


; Имплементирайте следните функции за двоични дървета:

; Връща списък от всички върхове на разстояние n от корена на tree.
(define (level n tree) void)

; Намира броя на листата в tree.
(define (count-leaves tree) void)

; Връща ново дърво, в което f е приложена над всеки връх от tree.
(define (map-tree f tree) void)

; Обхождане на дърво, функциите да връщат списък от върховете в реда на обхождането им

; корен-ляво-дясно
(define (pre-order t) void)

; ляво-корен-дясно
(define (in-order t) void)

; ляво-дясно-корен
(define (post-order t) void)



; Асоциативен списък е списък от двойки (<key> . <value>)
; Имплементирайте следните функции за работа със асоциативни списъци

; По списък от ключове и функция създава асоциативен списък с двойки от вида
; (keyi . (f keyi))
(define (make-alist fn keys) void)

; Връща списък от ключовете на асоциативен
(define (alist-keys alist) void)

; Връща списък от стойностите на асоциативен списък
(define (alist-values alist) void)

; По дадени ключ и асоциативен списък, връща стойността от първата намерена двойка с ключа
(define (alist-assoc key alist) void)

; По даден ключ изтрива първата съответстваща двойка със същия ключ
(define (del-assoc key alist) void)

; Добавя двойка с дадени ключ и стойност в асоциативен списък
(define (add-assoc key value alist) void)


; Граф ще представяме като списък на съседство

; Дефинирайте следните функции за работа с графи
; (може да ползвате горните функции за асоциативни списъци)

; връща граф с върхове vs и празно множество от ребра.
(define (make-graph vs) void)

; проверява дали графа g е празен.
(define (empty-graph? g) void)

; проверява дали има ребро между върховете u и v в g.
(define (edge? u v g) void)

; връща списък от върховете в графа g.
(define (vertices g) void)

; връща списък от всички ребра на графа g.
(define (edges g) void)

; връща списък от децата на върха v в g.
(define (children v g) void)

; връща списък от прилаганията на функцията f върху децата на v в g.
(define (map-children v f g) void)

; връща първото дете на v в g, което е вярно за предиката p.
(define (search-child v p g) void)

; добавяне на  върха v в графа g.
(define (add-vertex v g) void)

; премахване на върха v от графа g.
(define (remove-vertex v g) void)

; добавяне на ребро от u към v в g.
(define (add-edge u v g) void)

; премахване на ребро от u към v в g.
(define (remove-edge u v g) void)


; Имплементирайте следните функции за графи.

; връща степента на върха v в графа g.
(define (degree v g) void)

; проверява дали графа g е симетричен.
(define (symmetric? g) void)

; инвертира графа g. Тоест за всяко ребро (define (u,v) void) в g новият граф ще има реброто (v,u).
(define (invert g) void)

; проверява дали има път между върховете u и v в графа g.
(define (path? u v g) void)

; проверява дали графа g е ацикличен.
(define (acyclic? g) void)
