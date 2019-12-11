## Можете да ползвате която и да е функция оттук, за да имплементирате която и да е друга.
(както обикновено)


## 0. (?т.) `group`

Групира съседните елементи на даден списък, които са равни един на друг, в списъци.
```haskell
group :: Eq a => [a] -> [[a]]
```

Примери:
```haskell
> group []
[]
> group [69]
[[69]]
> group [1,2,3]
[[1],[2],[3]]
> group [1,1,2,1,3,1,3,3,2,1,2,2]
[[1,1],[2],[1],[3],[1],[3,3],[2],[1],[2,2]]
```

## 1. (?т.) `sortBy`

Сортира списък по подадена наредба.

Няма значение точно кой алгоритъм ще изберете за сортирането.

(лично за мен най-лесно тук е с insertion sort)
```haskell
sortBy :: (a -> a -> Ordering) -> [a] -> [a]
```

Типът `Ordering` [е дефиниран](https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#t:Ordering) по следния начин:
```haskell
data Ordering = LT | EQ | GT
```

Ще искаме той да означава "резултат от сравнение на две неща".
Функцията `compare` от типовия клас `Ord` връща `Ordering`.

Примери:
```haskell
> compare 5 10
LT
> compare 5 5
EQ
> compare 5 3
GT
> compare False True
LT
> compare True False
GT
> compare True True
EQ
> compare EQ EQ
EQ
> compare LT GT
LT
> compare 'a' 'b'
LT
> compare 'a' 'A'
GT
```

## 2. (?т.) `groupBy`

Като `group`, но взима предикат който да казва дали два елемента са "равни".

Очаква се подадените предикати към `groupBy` да са [релации на еквивалентност](https://en.wikipedia.org/wiki/Equivalence_relation).

Ще срещнете случай(/и) в рекурсията си, който не би трябвало да е възможен,
ако `groupBy` е имплементирана правилно.

Там е ок да сложите `error "The impossible has happened"`.

Бонусът към това домашно се отнася към това как да **"докажем"**, че този случай е невъзможен
и да разкараме `error`-а.

```haskell
groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
```
Примери:

```haskell
> groupBy (==) []
[]
> groupBy (==) [1,1,2,1]
[[1,1],[2],[1]]
> groupBy (\x y -> even x == even y) [1..10]
[[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]]
> groupBy (\x y -> even x == even y) [1,3,2,4,5]
[[1,3],[2,4],[5]]
> groupBy ((==) `on` odd) [1,3,2,4,5,7,10]
[[1,3],[2,4],[5,7],[10]]
> groupBy ((==) `on` (`rem` 3)) [1,3,2,4,5,7,10] -- compare numbers modulo 3
[[1],[3],[2],[4],[5],[7,10]]
```
Функцията `on` е от следващата задача (но сме я реализирали и в час)


## 3. (0т. - HINT) `on`
Прилага функция на два аргумента, като първо прекарва всеки аргумент
през предварителна обработка.

```haskell
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
```
Примери:
```haskell
> on (+) succ 0 1
3
> ((&&) `on` even) 2 4
True
> ((||) `on` even) 3 4
True
> ((||) `on` even) 3 5
False
> (compare `on` even) 3 5
EQ
> (compare `on` even) 3 6
LT
> (compare `on` (`rem` 3)) 4 13
EQ
> (compare `on` (`rem` 3)) 4 15
GT
> (compare `on` (`rem` 3)) 4 14
LT
```

## 4. (?т.) `sortOn`

Сортира списък, като ползва функция за трансформация и наредбата
над резултата на функцията.

Няма значение точно кой алгоритъм ще изберете за сортирането.

Опитайте се да реализирате функцията по такъв начин, че за всеки елемент на входящия списък,
входящата функция се прилага **само веднъж**. Това ще е предимство на тази функция над `sortBy`.
```haskell
sortOn :: Ord b => (a -> b) -> [a] -> [a]
```

Примери:
```haskell
> sortOn id [1..5]
[1,2,3,4,5]
> sortOn even [1..10]
[1,3,5,7,9,2,4,6,8,10]
> sortOn (`rem` 5) [1..20]
[5,10,15,20,1,6,11,16,2,7,12,17,3,8,13,18,4,9,14,19]

-- cool example
> data Down a = Down a deriving Eq
> instance Ord a => Ord (Down a) where compare (Down x) (Down y) = compare y x
> sortOn Down [1..10]
[10,9,8,7,6,5,4,3,2,1]
> sortOn Down ['A'..'z']
"zyxwvutsrqponmlkjihgfedcba`_^]\\[ZYXWVUTSRQPONMLKJIHGFEDCBA"
> sortOn (Down . Down) [1..10]
[1,2,3,4,5,6,7,8,9,10]
```
