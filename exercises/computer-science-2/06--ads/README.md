# Упражнение 6 – Структури от данни
## Матрици
#### Задача 1
Напишете функция `(transpose m)`, която транспонира матрица.

#### Задача 2
Напишете функция `(multiply m1 m2)`, която връща произведението на матриците `m1` и `m2`.

#### Задача 3
Напишете функция `(map-matrix f m)`, която прилага `f` върху всеки от елементите на `m`.

#### Задача 4
Напишете функция `(main-diagonal m)`, която връща главния диагонал на матрицата `m`.
Пример:
```scheme
(main-diagonal (from-rows '((1 2 3)
                            (4 5 6)))) ; -> '(1 5)
```
> `(from-rows l)` връща матрица по даден списък с редове


#### Задача 5
Напишете функция `(foldr-matrix op-rows nv-rows op-elems nv-elems m)`, която свива матрицата `m`, като прилага двуместната функция `op-elems` върху елементите във всеки ред, с начална стойност `nv-elems`. Резултатът от свиването на всеки от редовете го дава на двуместната функция `op-rows` с начална стойност `nv-rows`.
Пример:
```scheme
(foldr-matrix + 0 * 1 (from-rows '((3 4 5) (6 7 8))))
; изчислява се като (+ (* 3 (* 4 (* 5 1)))
;                      (* 6 (* 7 (* 8 1)))
;                      0)
```

## Двоични дървета
#### Задача 1
Напишете функции `(collect-pre-order t)`, `(collect-in-order t)` и `(collect-post-order t)`, които връща списък от елементите на дървото, обходено съотвено `корен-ляво-дясно`, `ляво-корен-дясно` и `ляво-дясно-корен`.

#### Задача 2
Напишете функция `(height)`, която намира височината на дървото `t`. Това е броят на върховете в най-дългия път.

#### Задача 3
Напишете функция `(level n t)`, която връща списък с всички върхове от дървото с дълбочина `n`.
> Дълбочината на един връх `x` от дърво е броят ребра, които го свързват с корена `r`. Това е равно и на броя върхове от `r` до `x`, без да броим `x`. Дълбочината на корена е 0.

#### Задача 4
Напишете функция `(count-leaves t)`, която връща броя листа на t.
> Листо е връх от дърво, който няма наследници.

#### Задача 5
Напишете функция `(remove-leaves t)`, която връща дървото t, премахвайки листата му.

#### Задача 6
Напишете функция `(map-tree f t)`, която заменя всеки връх `x` от дървото `t` с `(f x)`.

#### Задача 7
Напишете функция `(fold-tree f nv t)`, която свива двоичното дърво `t` прилагайки триместната функция `f` над всеки от елементите, като празното дърво го замества с `nv`.

#### Задача 8
Напишете функция `(invert t)`, която разменя левите поддървета на `t` с десните.

#### Задача 9
Напишете функция `(bst? t)`, която намира дали `t` двоично **наредено** дърво.

#### Задача 10
Напишете функция `(insert-bst x t)`, която добавя елемент `x` в двоично **наредено** дърво `t`, запазвайки наредбата му.
> Така може да направите функция `(list->bst l)`, която по списък прави наредено дърво, и чрез някоя от `collect` функциите от задачa 1 може да реализирате сортиране на списък.


## Асоциативни списъци
#### Задача 1
Напишете функция `(index l)`, която връща асоциативен списък, в който всеки елемент `x` на `l` е асоцииран с ключ, равен на позицията на `x` в `l`.

#### Задача 2
Напишете функция `(histogram l)`, която
връща хистограма на срещанията на всички елементи в `l` под формата на асоциативен списък.

   Например, `(histogram '(8 7 1 7 8 2 2 8 2 7 8 1))`
   връща асоциативния списък `'((8 . 4) (7 . 3) (1 . 2) (2 . 3))`.

#### Задача 3
Напишете функция `(group-by f l)`, която
връща асоциативен списък, в който ключовете са стойностите на функцията `f` след прилагането ѝ върху елементи от списъка `l`, а
срещу ключовете стои списък от елементите, за които функцията `f` дава стойността от ключа.

   Например, `(group-by (lambda (x) (remainder x 3)) '(0 1 2 3 4 5 6 7 8))`
   връща асоциативния списък `'((0 0 3 6) (1 1 4 7) (2 2 5 8))`.

   
#### Задача 4
Напишете функция, която в асоциативен списък изчиства дублирани ключове, като запазва само първата стойност.


#### Задача 5
Напишете функция, която слива два асоциативни списъка, като за общите ключове прилага двуместна операция подадена като аргумент.

#### Задача 6
Напишете функция, която композира два асоциативни списъка с целочислени ключове и стойности, разглеждайки ги като функции.
Пример: 
```scheme
(compose '((1 . 2) (2 . 3) (3 . 4)) ((2 . 20) (4 . 40) (6 . 60))) ; да връща ((1 . 20) (3 . 40))
```

Разглеждайки асоциативните списъци като множества от наредени двойки, композицията на `al1` и `al2` е: 
    { <x, z> | <x, y> ∈ al1 & <y, z> ∈ al2 }

