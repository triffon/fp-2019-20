## 00. (0.5т.) Поточкова наредба над наредени двойки

```haskell
newtype Pointwise a b = Pointwise {getPointwise :: (a, b)}

instance (Ord a, Ord b) => Ord (Pointwise a b) where
```

Имплементирайте инстанция на `Ord` за `Pointwise`,
такава че един `Pointwise` да е по-малък или равен на друг т.с.т.к.
и двете компоненти на първия са по-малки или равни от тези на втория.

Примери:
```haskell
> Pointwise (3,5) < Pointwise (4,6)
True

> Pointwise (3,5) < Pointwise (4,1)
False

> Pointwise ('a','b') <= Pointwise ('A','z')
False

> Pointwise ('a','b') <= Pointwise ('a','z')
True
```

## 01. (0.5т.) Лексикографска наредба над наредени двойки
**N.B.**: Това е инстанцията на `Ord` за `(a, b)`, която има по подразбиране
във вградените библиотеки. Идеята е да **я напишете сами**.

```haskell
newtype Lexicographic a b = Lexicographic {getLexicographic :: (a, b)}

instance (Ord a, Ord b) => Ord (Lexicographic a b) where
```

Имплементирайте инстанция на `Ord` за `Lexicographic`,
такава че един `Lexicographic` да е по-малък или равен на друг т.с.т.к.
или първите компоненти са по-малки, или първите компоненти са равни,
а вторите са по-малки или равни.

Примери:
```haskell
> Lexicographic (3,5) < Lexicographic (4,6)
True

> Lexicographic (3,5) < Lexicographic (4,1)
True

> Lexicographic ('a','b') <= Lexicographic ('A','z')
False

> Lexicographic ('a','b') <= Lexicographic ('a','z')
True

> Lexicographic ('a','b') <= Lexicographic ('a','b')
True
```

## 02. (1т.) Поточков моноид за функции чийто кодомейн е моноид
**N.B.**: Това е инстнацията на `Monoid` за `a -> b`, която има по подразбиране
във вградените библиотеки. Идеята е да **я напишете сами**.

```haskell
newtype Fun a b = Fun {getFun :: a -> b}

instance (Semigroup b) => Semigroup (Fun a b) where

instance (Monoid b) => Monoid (Fun a b) where
```

Имплементирайте инстанция на `Monoid` за `Fun`, такава че тя вдига "поточково"
моноида който има в кодомейна (това отдясно на стрелката) на `Fun`.

Примери:
```haskell
> getFun (Fun reverse <> Fun (++[1,2,3])) []
[1,2,3]

> getFun (Fun reverse <> Fun (++[1,2,3])) [69]
[69,69,1,2,3]

> getFun (Fun ("what the "++) <> Fun (++" is this")) "fun"
"what the funfun is this"

> getFun (Fun reverse <> Fun reverse) [4,5,6]
[6,5,4,6,5,4]

> getFun (Fun reverse <> Fun id) [4,5,6]
[6,5,4,4,5,6]
```

## 03. (1т.) `Maybe` със семантика на "взимам първия/последния"
```haskell
newtype First a = First {getFirst :: Maybe a}
  deriving (Eq, Show)

instance Semigroup (First a) where

instance Monoid (First a) where

newtype Last a = Last {getLast :: Maybe a}

instance Semigroup (Last a) where

instance Monoid (Last a) where
```

Имплементирайте инстанция на `Monoid` за `First/Last`, такава че тя винаги взима
"първи"/"последния" срещнат `Just`. Инстанциите трябва да игнорират ненужните
си аргументи. Това е полезно когато имате много операции които дават резултат,
но искате само първият/последният.

Примери:
```haskell
> First (Just "nice") <> First undefined
First {getFirst = Just "nice"}

> Last undefined <> Last (Just "nice")
Last {getLast = Just "nice"}

> matches kx (k, v) = if kx == k then Just v else Nothing
> :t matches
matches :: Eq a1 => a1 -> (a1, a2) -> Maybe a2

> findFirst k = getFirst . foldMap (First . matches k)
> findFirst 1 [(1, "MGLA"), (2, "nice"), (1, "GY!BE")]
Just "MGLA"

> findLast k = getLast . foldMap (Last . matches k)
> findLast 1 [(1, "MGLA"), (2, "nice"), (1, "GY!BE")]
Just "GY!BE"
```

## 04. (0.5т.) Поточков `Monoid` над наредени двойки.
**N.B.**: Това е инстанцията на `Monoid` за `(a, b)`, която има по подразбиране
във вградените библиотеки. Идеята е да **я напишете сами**.
```haskell
newtype Pair a b = Pair {getPair :: (a, b)}
  deriving (Show, Eq)

instance (Semigroup a, Semigroup b) => Semigroup (Pair a b) where

instance (Monoid a, Monoid b) => Monoid (Pair a b) where
```

Имплементирайте инстанция на `Monoid` за `(a, b)`, такава че
отделните `Monoid`-и върху `a` и `b` са "вдигнати" да работят над наредената двойка.

Примери:
```haskell
> Pair (Sum 5, Product 5) <> Pair (Sum 6, Product 6)
Pair {getPair = (Sum {getSum = 11},Product {getProduct = 30})}

> matches kx (k, v) = if kx == k then Just v else Nothing
> bimap f g (x, y) = (f x, g y) -- can import from Data.Bifunctor
> findFirstLast k
    = bimap getFirst getLast
    . getPair
    . foldMap (\kv -> Pair (First $ matches k kv, Last $ matches k kv))
            -- alternative implementation of mapping function:
            -- (Pair . ((First . matches k) &&& (Last . matches k)))
-- ^ there is actually a cleaner way to do unwrapping
-- but we won't discuss it here

> :t findFirstLast
findFirstLast
  :: (Eq a1) => a1 -> [(a1, a)] -> (Maybe a, Maybe a)

> findFirstLast 1 [(1, "MGLA"), (2, "nice"), (1, "GY!BE")]
(Just "MGLA",Just "GY!BE")

> findFirstLast 1 [(1, "MGLA"), (2, "nice"), (1, "lil peep"), (1, "GY!BE")]
(Just "MGLA",Just "GY!BE")
```

## 05. (1т.) Обръщане на операцията на `Monoid`

### 05.00. (0.5т.) `Dual`
```haskell
newtype Dual a = Dual {getDual :: a}
  deriving (Show, Eq)

instance Semigroup a => Semigroup (Dual a) where

instance Monoid a => Monoid (Dual a) where
```

Имплементирайте инстанция на `Monoid` за `a`, такава че
операцията на `Monoid`-а върху `a` да е с разменени аргументи.

Примери:
```haskell
> getFirst $ First (Just 10) <> First (Just 5)
Just 10

> getFirst $ getDual $ Dual (First (Just 10)) <> Dual (First (Just 5))
Just 5

> getFirst $ getDual $ getDual $ Dual (Dual (First (Just 10))) <> Dual (Dual (First (Just 5)))
Just 10

> getDual $ Dual [1,2,3] <> Dual [4,5,6]
[4,5,6,1,2,3]
```

### 05.01. (0.5т.) `reverse` чрез `Dual`
```haskell
reverse :: [a] -> [a]
```

Имплементирайите `reverse` изполвзайки `foldl/foldr/foldMap` и `Dual`.

Има ли значение кое от трите ще използвате за сложността на `reverse` (и ако да, кое е най-ефективно)?

## 06. (1.5т.) Броене на промени
```haskell
data Flux a = Flux
  { sides :: Maybe (a, a)
  , changes :: Int
  }
  deriving (Show, Eq)

flux :: a -> Flux a
flux x = Flux (Just (x, x)) 0

instance (Eq a) => Semigroup (Flux a) where

instance (Eq a) => Monoid (Flux a) where
```

С типа `Flux` можем да броим колко пъти се сменя стойност.
Той държи в себе си две неща:
* `sides` - Какви са "първият" и "последният" срещан елемент, ако има такива.
* `changes` - Колко пъти се е сменяла стойността.

Имплементирайте инстанция на `Monoid` за `Flux a`, такава че
тя операцията за слепване комбинира два `Flux`-а,
съобразявайки се с това дали стойността се сменя (заради това
е нужно `Eq` ограничението) между левия и десния `Flux`.

Примери:
```haskell
> flux 1
Flux {sides = Just (1,1), changes = 0}

> flux 2
Flux {sides = Just (2,2), changes = 0}

> flux 1 <> flux 2
Flux {sides = Just (1,2), changes = 1}

> flux 1 <> flux 2 <> flux 3
Flux {sides = Just (1,3), changes = 2}

> flux 1 <> flux 2 <> flux 3 <> flux 1
Flux {sides = Just (1,1), changes = 3}

> flux 1 <> mempty
Flux {sides = Just (1,1), changes = 0}

> mempty <> flux 1
Flux {sides = Just (1,1), changes = 0}

> changes $ foldMap flux [1,1,1,1]
0

> changes $ foldMap flux [1,2,1,2]
3

> changes $ foldMap flux [1,2,1,2,2,2,2]
3

> changes $ foldMap flux [1,2,1,2,2,2,2,3,2]
5

> changes $ foldMap flux [1,2,1,2,2,2,2,3,2,4]
6
```
