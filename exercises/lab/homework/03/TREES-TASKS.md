# Бележка за обхождане
Когато работим с дървета има много начини по които можем да ги обхождаме.

Нека изберем "ляво корен дясно" за всички задачи по-долу

Пример:
```haskell
> treeToList (Node 2 (Node 4 (Node 5 Empty Empty) Empty) (Node 7 Empty Empty))
[5,4,2,7]
```
Има тестове, които зависят от това (например тестът който проверява че правенето
на двоично наредено дърво сортира списък).

## 00. (1т.) Равенство на дървета
```haskell
data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show

instance Eq a => Eq (Tree a) where
```

Имплементирайте "структурно" равенство за дървета.

Примери:
```haskell
> Empty == Empty
True

> Empty == Node 2 Empty Empty
False

> Node 2 Empty Empty == Node 3 Empty Empty
False

> Node 2 (Node 4 Empty Empty) Empty == Node 2 (Node 4 Empty Empty) Empty
True
```

## 01. (4т.) Двоични наредени дървета
Ще имплементираме някои функционалности на [двоично наредено дърво](https://en.wikipedia.org/wiki/Binary_search_tree).

### 01.00. (1т.) Вмъкване
```haskell
insertOrdered :: Ord a => a -> Tree a -> Tree a
```

Напишете функция, която вмъква елемент в дърво, при презумцията, че то е
двоично наредено дърво.

При вмъкване на стойност, която вече присъства в дървото, се приема че
тя се вмъква втори път.

Искаме резултатното дърво също да е двоично наредено дърво.

Примери:
```haskell
> insertOrdered 5 Empty
Node 5 Empty Empty

> insertOrdered 5 (Node 7 Empty Empty)
Node 7 (Node 5 Empty Empty) Empty

> insertOrdered 10 (Node 7 Empty Empty)
Node 7 Empty (Node 10 Empty Empty)

> insertOrdered 7 (Node 8 (Node 6 Empty Empty) Empty)
Node 8 (Node 6 Empty (Node 7 Empty Empty)) Empty

> insertOrdered 7 (Node 8 (Node 6 Empty (Node 7 Empty Empty)) Empty)
Node 8 (Node 6 Empty (Node 7 (Node 7 Empty Empty) Empty)) Empty
```

### 01.01. (0.5т.) Строене от списък
```haskell
listToBST :: Ord a => [a] -> Tree a
```

Построете двоично наредено дърво по подаден списък.

N.B.: Не е нужно резултатът ви да е точно както примерите,
а само да е двоично наредено дърво.

Примери:
```haskell
> listToBST []
Empty

> listToBST [1,2,3]
Node 3 (Node 2 (Node 1 Empty Empty) Empty) Empty

> listToBST [2,1,3]
Node 3 (Node 1 Empty (Node 2 Empty Empty)) Empty

> listToBST [0..10]
Node 10 (Node 9 (Node 8 (Node 7 (Node 6 (Node 5 (Node 4 (Node 3 (Node 2 (Node 1 (Node 0 Empty Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty

> listToBST [5,4,6,3,7,2,8,1,9,0,10]
Node 10 (Node 0 Empty (Node 9 (Node 1 Empty (Node 8 (Node 2 Empty (Node 7 (Node 3 Empty (Node 6 (Node 4 Empty (Node 5 Empty Empty)) Empty)) Empty)) Empty)) Empty)) Empty
```

### 01.02. (1.5т.) Проверка за двоично наредено дърво
```haskell
isBST :: Ord a => Tree a -> Bool
```

Проверете дали дърво е двоично наредено дърво.

Примери:
```haskell
> isBST $ Node 8 (Node 6 Empty (Node 7 Empty Empty)) Empty
True

> isBST Empty
True

> isBST $ Node 8 (Node 6 Empty (Node 7 Empty Empty)) Empty
True

> isBST $ Node 8 (Node 6 Empty Empty) Empty
True

> isBST $ listToBST [0..10]
True

> isBST $ listToBST [0..1000]
True
```
**(яка) Идея за имплементация:**
```haskell
data BotTop a = Bot | Val a | Top
  deriving (Show, Eq, Ord)
```
Със следния тип ще изразяваме наредбата на `a`, но с добавени
"най-малък" (`Bot`) и "най-голям" (`Top`) елементи.

(това е точно автоматично генерираната инстанция за `Ord`)

Примери:
```haskell
> Bot <= Top
True

> Top <= Bot
False

> Bot <= Val 0
True

> Top <= Val 0
False

> Bot <= Val (minBound :: Int)
True

> Top <= Val (maxBound :: Int)
False
```

Имплементирайте рекурсивно следната функция:
```haskell
between :: Ord a => BotTop a -> BotTop a -> Tree a -> Bool
```

с идеята че тя ще проверява дали двоично наредено дърво е между подадените граници.

След това `isBST` е просто
```haskell
isBST = between Bot Top
```

Примери:
```haskell
> between (Val 0) (Val 10) $ Node 8 (Node 6 Empty Empty) Empty
True

> between (Val 0) (Val 5) $ Node 8 (Node 6 Empty Empty) Empty
False

> between (Val 7) (Val 10) $ Node 8 (Node 6 Empty Empty) Empty
False
```
**HINT (don't read straight away)** за `between`:

Идеята ни за `between` е че всеки път когато слизаме в ляво и дясно поддърво,
искаме да "обновяваме" изискванията ни за границите им, взимайки предвид
елемента в сегашния връх и дали влизаме в лявото или в дясното поддърво.

Празното дърво е между каквито и да са граници (защото то няма елементи),
стига границите да са "валидни" - лявата да е по-малка или равна на дясната.

### 01.03. (1т.) Търсене в двоично наредено дърво
```haskell
findBST :: Ord a => a -> Tree a -> Bool
```

Намерете дали присъства елемент в дърво, възползвайки се от това че то е двойчно наредено дърво,
с цел да имаме логаритмично търсене, ако дървото е балансирано.

Примери:
```haskell
> findBST 5 $ listToBST [5,4,6,3,7,2,8,1,9,0,10]
True

> findBST 69 $ listToBST [5,4,6,3,7,2,8,1,9,0,10]
False
```

## 02. (1т.) Поточково преубразуване (`map`) на дървета
```haskell
mapTree :: (a -> b) -> Tree a -> Tree b
```

Имплементирайте `map` за дървета.

Примери:
```haskell
> mapTree succ $ Node 8 (Node 6 Empty Empty) (Node 7 Empty Empty)
Node 9 (Node 7 Empty Empty) (Node 8 Empty Empty)

> mapTree even $ Node 8 (Node 6 Empty Empty) (Node 7 Empty Empty)
Node True (Node True Empty Empty) (Node False Empty Empty)

> mapTree odd $ Node 8 (Node 6 Empty Empty) (Node 7 Empty Empty)
Node False (Node False Empty Empty) (Node True Empty Empty)
```

## 03. (6т.) Сгъвания

Не забравяйте за уговорката за реда на обхождане!

### 03.00. (1т.) Сгъване
```haskell
foldTree :: Monoid a => Tree a -> a
```

Примери:
```haskell
> foldTree Empty :: [Int]
[]

> foldTree $ Node [3,4] (Node [1,2] Empty Empty) (Node [5,6] Empty Empty)
[1,2,3,4,5,6]
```

### 03.01. (1т.) Господ-функцията
```haskell
foldMapTree :: Monoid b => (a -> b) -> Tree a -> b
```

Примери:
```haskell
> foldMapTree id $ Node [3,4] (Node [1,2] Empty Empty) (Node [5,6] Empty Empty)
[1,2,3,4,5,6]

> getDual $ foldMapTree Dual $ Node [3,4] (Node [1,2] Empty Empty) (Node [5,6] Empty Empty)
-- ^ from Instances
[5,6,3,4,1,2]
```

### 03.02. (0.5т.) Сумиране на дърво
```haskell
sumTree :: Num a => Tree a -> a
```

Използвайте `Data.Monoid.Sum` и `foldTreeMap` за да имплементиранте сумиране на дърво.

Примери:
```haskell
> sumTree $ Node 8 (Node 6 Empty Empty) (Node 7 Empty Empty)
21

> sumTree $ listToBST [0..100]
5050
```

### 03.03. (0.5т.) Проверка на "за всяко" за дърво
```haskell
allTree :: (a -> Bool) -> Tree a -> Bool
```

Използвайте `Data.Monoid.All` и `foldTreeMap` за да проверите дали предикат
важи за всичките елементи на дърво.

Примери:
```haskell
> allTree (<=100) $ listToBST [0..100]
True

> allTree (<100) $ listToBST [0..100]
False

> allTree even $ Node 8 (Node 6 Empty Empty) Empty
True
```

### 03.04. (0.5т.) "Спляскване" на дърво
```haskell
treeToList :: Tree a -> [a]
```

Използвайте подходящ моноид и `foldTreeMap` за да "спляскате" дърво в списък.

Примери:
```haskell
> treeToList $ Node 8 (Node 6 Empty Empty) Empty
[6,8]

> treeToList $ listToBST [0..10]
[0,1,2,3,4,5,6,7,8,9,10]

> treeToList $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
[6,8,7,13]
```

### 03.05. (0.5т.) Проверка за принадлежност
```haskell
elemTree :: Eq a => a -> Tree a -> Bool
```

Използвайте `Data.Monoid.Any` и `foldTreeMap` за да проверите дали дадена стойност
принадлежи на дърво.

Примери:
```haskell
> elemTree 8 $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
True

> elemTree 69 $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
False
```

### 03.05.00. (0т.) `onMaybe`
```haskell
onMaybe :: (a -> Bool) -> a -> Maybe a
```
Полезно при следващите задачи.

Примери:
```haskell
> onMaybe even 5
Nothing

> onMaybe even 6
Just 6
```

### 03.06. (1т.) Проверка за елемент, изпълняваш предикат
```haskell
findPred :: (a -> Bool) -> Tree a -> Maybe a
```

Използвайте `Instances.First/Last` (или пък `Data.Monoid.First/Last`) и `foldMapTree`, за
да проверите дали има елемент в дърво, изпълняващ даден предикат.

Примери:
```haskell
> findPred even $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 6

> findPred odd $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 7

> findPred (==0) $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Nothing
```

### 03.07. (1т.) Всички елементи, изпълняващи предикат

Използвайте подходящ моноид и `foldMapTree` за да вземете всички стойности от дърво,
които изплъняват даден предикат.

Примери:
```haskell
> findAll even $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
[6,8]

> findAll odd $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
[7,13]

> findAll (==0) $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
[]
```

## 04. (3т.) "Валидация" на дърво (обхождане със страничен ефект)

Ще имплементираме обхождане на дърво, с изчисление което може да има страничен ефект.

В този случай ще фиксираме страничният ни ефект да е "възможност за провал" - `Maybe`.

### 04.00. (0т.) `ifJust` - навръзване на `Maybe` изчисления
```haskell
ifJust :: Maybe a -> (a -> Maybe b) -> Maybe b
```
Функция, която ни помага лесно да навръзваме много изчисления включващи `Maybe`
стойности.

Примери:
```haskell
> Nothing `ifJust` (\x -> Just (x + 1))
Nothing

> Just 5 `ifJust` (\x -> Just (x + 1))
Just 6

> Nothing `ifJust` (\x -> if even x then Just (2 * x) else Nothing)
Nothing

> Just 7 `ifJust` (\x -> if even x then Just (2 * x) else Nothing)
Nothing

> Just 7 `ifJust` (\z -> Just (z + 1) `ifJust` (\x -> if even x then Just (2 * x) else Nothing))
Just 16
```

### 04.01. (3т.)
```haskell
validateTree :: (a -> Maybe b) -> Tree a -> Maybe (Tree b)
```

Искаме да обходим дърво с дадената функция, като ако в който и да е момент
получим `Nothing` ("изчислението ни е се провали"), искаме цялата сметка да спре.

`isJust` е много полезно тук за да не стане мазало от `case`-ове.

Не забравяйте за уговорката за обхождане.

Примери:
```haskell
> validateTree (onMaybe even) $ Node 4 (Node 2 Empty Empty) (Node 0 Empty Empty)
Just (Node 4 (Node 2 Empty Empty) (Node 0 Empty Empty))

> validateTree (onMaybe even) $ Node 4 (Node 2 Empty Empty) (Node 0 (Node 3 Empty Empty) Empty)
Nothing

> validateTree (lookup 1) $ Node [(1, 'a')] (Node [(1, 'b')] Empty Empty) (Node [(1, 'c')] Empty
Empty)
Just (Node 'a' (Node 'b' Empty Empty) (Node 'c' Empty Empty))

> validateTree (lookup 1) $ Node [(1, 'a')] (Node [(1, 'b')] Empty Empty) (Node [(2, 'c')] Empty
Empty)
Nothing
```

## 05. (2т.) Пътища в дърво
```haskell
data Direction
  = L -- go left
  | R -- go right
  deriving (Show, Eq)
```

Чрез списък този тип данни ще изразяваме "пътят" до даден елемент на дърво.

### 05.00. (0.5т.) Стигане до елемент по път
```haskell
fetch :: [Direction] -> Tree a -> Maybe a
```

Извлечете елемент по даден път.

Примери:
```haskell
> fetch [] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 8

> fetch [L] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 6

> fetch [L,R] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Nothing

> fetch [R,R] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 13

> fetch [R,L] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Nothing

> fetch [R] $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
Just 7
```

### 05.01. (1.5т.) Пътища до всички елементи
```haskell
paths :: Tree a -> [(a, [Direction])]
```
Имплементирайте функция, която по дадено дърво връща асоциативен списък от всеки
негов елемент и пътя до съотвения елемент.

**HINT/IDEA:** Може да ви е полезно да имплементирате функция която по дърво,
връща "асоциативно дърво", закачайки на всеки елемент на оргиналното пътя до съответния елемент.
```haskell
mapDirections :: Tree a -> Tree (a, [Direction])
```

Примери:
```haskell
> paths $ Node 8 Empty Empty
[(8,[])]

> paths $ Node 8 Empty (Node 10 Empty Empty)
[(8,[]),(10,[R])]

> paths $ Node 8 (Node 13 Empty Empty) (Node 10 Empty Empty)
[(13,[L]),(8,[]),(10,[R])]

> paths $ Node 8 (Node 6 Empty Empty) (Node 7 Empty (Node 13 Empty Empty))
[(6,[L]),(8,[]),(7,[R]),(13,[R,R])]

> paths $ listToBST [0..10]
[(0,[L,L,L,L,L,L,L,L,L,L]),(1,[L,L,L,L,L,L,L,L,L]),(2,[L,L,L,L,L,L,L,L]),(3,[L,L,L,L,L,L,L]),(4,[L,L,L,L,L,L]),(5,[L,L,L,L,L]),(6,[L,L,L,L]),(7,[L,L,L]),(8,[L,L]),(9,[L]),(10,[])]

> paths $ listToBST [5,4,6,3,7,2,8,1,9,0,10]
[(0,[L]),(1,[L,R,L]),(2,[L,R,L,R,L]),(3,[L,R,L,R,L,R,L]),(4,[L,R,L,R,L,R,L,R,L]),(5,[L,R,L,R,L,R,L,R,L,R]),(6,[L,R,L,R,L,R,L,R]),(7,[L,R,L,R,L,R]),(8,[L,R,L,R]),(9,[L,R]),(10,[])]
```
