## `shower`
За това домашно може да ви е полезен следният сайт (също и хаскелска библиотека):
[`shower`](https://monadfix.com/shower)

В него може да сложите изход от `Show`, от инстанцията по подразбиране, за да получите "разкрасен" такъв.

## `NamedFieldPuns`
Във файла е пуснато `NamedFieldPuns` - разширение на езика, правещо работата със записи много по-удобна.

Пример:

Когато правим pattern match с взимане на полета, вместо да пишем
```haskell
toAssocList Trie {val = val, children = children} ...
```

можем да пишем

```haskell
toAssocList Trie {val, children} = ...
```

постигайки същия ефект.

Нормалният синтаксис още ни е наличен, ако искаме да кръстим поле по друг начин.

## [`Trie`](https://en.wikipedia.org/wiki/Trie) (<- цък)

`Trie a` е структура от данни, която има интръфейс на `Map` от низове към `a`-та.
Тя се имплементира като дърво, в което (интуитивно) ако искаме да пазим `(k, v)`
стойността `v` се намира на "път" `k` в дървото.

Нарича се също така и префиксно дърво и се оказва полезна в доста ситуации,
свързани с обработка на текст.

Пример за едно приложение би било по-бързо "допълване" на резултати, за частично написан низ,
както прави `hoogle`, докато пишете. Това е възможно, защото можем да вземем под-`Trie` за дадения низ.

Нашата имплементация ще е наивна (например няма компресия на пътища, т.е. ако имаме само
`"asdf"` като ключ, да не се пази отделен връх за всеки от символите `'a'`, `'s'`, `'d'`, `'f'`), с цел простота.

Ето я и структурата ни данни:
```haskell
data Trie a = Node
  { val :: Maybe a
  , children :: [(Char, Trie a)]
  }
  deriving (Show, Eq)
```
Имаме един конструктор.

За всеки връх пазим потенциално стойност в него - `val :: Maybe a`

Това е така, защото в `Trie`-то ни може и да има стойност за `"asdf"`, но може и да няма.

Не е достатъчно да пазим стойности само по листата -
например ако вкараме стойности с ключове `"asdf"` и после `"as"` ще трябва и на междинен връх да пазим стойност.

Другото нещо в конструктора ни е децата на всеки връх - `children :: [(Char, Trie a)]`.

Представяме ги чрез асоциативен списък от символи и други `Trie`-та.

По този начин образуваме пътя към стойностите в `Trie`-то.

Тук би свършила работа всякаква структура от данни, която има интърфейс на `Map`, но за простота се спираме на асоциативни списъци.


Примери за `Trie`-та:

Празно `Trie`:

```haskell
Node {val = Nothing, children = []}
```

`Trie` с една стойност `42`, с ключ `""` (празен низ):
```haskell
Node {val = Just 42, children = []}
```
`Trie` с три стойности:
* ключ `"as"`, стойност 42
* ключ `"asdf"`, стойност 69
* ключ `"asqw"`, стойност 1337
```haskell
Node
  Nothing
  [('a',
    Node
      Nothing
      [('s',
        Node
          (Just 42)
          [('d', Node Nothing [('f', Node (Just 69) [])]),
           ('q', Node Nothing [('w', Node (Just 1337) [])])])])]
```
Или изпринтено "по-грозно" (get used to it):
```haskell
Node
  {val = Nothing,
   children =
     [('a',
       Node
         {val = Nothing,
          children =
            [('s',
              Node
                {val = Just 42,
                 children =
                   [('d',
                     Node
                       {val = Nothing,
                        children =
                          [('f', Node {val = Just 69, children = []})]}),
                    ('q',
                     Node
                       {val = Nothing,
                        children =
                          [('w',
                            Node {val = Just 1337, children = []})]})]})]})]}
```

## 00. (1т.) `Functor`

Направете инстанция на `Functor` за `Trie`:

```haskell
instance Functor Trie where
  fmap :: (a -> b) -> Trie a -> Trie b
```

Примери:
```haskell
> fmap (+1) $ Node (Just 42) []
Node {val = Just 43, children = []}
> fmap (+1) $ Node (Just 42) [('a', Node (Just 69) []), ('b', Node (Just 1337) [])]
Node {val = Just 43, children = [('a',Node {val = Just 70, children = []}),('b',Node {val = Just 1338, children = []})]}
```

## 01. (4т.) `Foldable`

Направете инстанция на `Foldable` за `Trie`:

```haskell
instance Foldable Trie where
  foldMap :: Monoid b => (a -> b) -> Trie a -> b
  -- alternatively implement
  -- foldr :: (a -> b -> b) -> b -> Trie a -> b
```

Ще ви е полезно да извиквате `foldMap` и за типовете, които държи в себе си `Node`.

Примери:
```haskell
> import Data.Foldable
> toList $ Node (Just 42) []
[42]
> toList $ Node (Just 42) [('a', Node (Just 69) []), ('b', Node (Just 1337) [])]
[42,69,1337]
> sum $ Node (Just 42) [('a', Node (Just 69) []), ('b', Node (Just 1337) [])]
1448
> product $ Node (Just 42) [('a', Node (Just 69) []), ('b', Node (Just 1337) [])]
3874626
> import Data.Monoid (All(..))
> getAll $ foldMap (All . even) $ Node (Just 42) [('a', Node (Just 69) []), ('b', Node (Just 1337) [])]
False
```

## 02. (1т.) `modify`
В асоциативен списък, модифицирайте стойността на подадения ключ,
да е като подадената стойност.

```haskell
modify :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
```

Примери:
```haskell
> modify "asdf" 10 []
[]
> modify "asdf" 10 [("asdf", 5)]
[("asdf",10)]
> modify "asdf" 10 [("asd", 5)]
[("asd",5)]
> modify "asdf" 10 [("lol", 13), ("asdf", 5)]
[("lol",13),("asdf",10)]
```

## 03. (3т.) `insert`

Вмъкнете подадената стойност в `Trie`, така че ключът ѝ да е подаденият `String`.

**N.B.**:
Тестовете за `insert` разчитат на `lookupTrie` (и обратното),
но за удобство в `ghci` може да ви е полезно да имплементиранте първо `fromAssocList`.

Примери:
```haskell
> insert "" 1 (Node Nothing [])
Node {val = Just 1, children = []}
> insert "a" 1 (Node Nothing [])
Node {val = Nothing, children = [('a',Node {val = Just 1, children = []})]}
> insert "as" 2 $ insert "a" 1 (Node Nothing [])
Node {val = Nothing, children = [('a',Node {val = Just 1, children = [('s',Node {val = Just 2, children = []})]})]}
> insert "ad" 3 $ insert "as" 2 $ insert "a" 1 (Node Nothing [])
Node
  {val = Nothing,
   children =
     [('a',
       Node
         {val = Just 1,
          children =
            [('d', Node {val = Just 3, children = []}),
             ('s', Node {val = Just 2, children = []})]})]}
```

## 04. (2т.) `lookupTrie`

Извлечете стойността от `Trie` по подадения низ (ключ):

```haskell
lookupTrie :: String -> Trie a -> Maybe a
```

Примери:
```haskell
> lookupTrie "a" $ Node Nothing []
Nothing
> lookupTrie "a" $ fromAssocList [("as", 10)]
Nothing
> lookupTrie "as" $ fromAssocList [("as", 10)]
Just 10
> lookupTrie "as" $ insert "as" 10 $ Node Nothing []
Just 10
> lookupTrie "a" $ insert "as" 10 $ Node Nothing []
Nothing
```

## 05. (1т.) `fromAssocList`

Направете `Trie` по подадения асоциативен списък:
```haskell
fromAssocList :: [(String, a)] -> Trie a
```

**N.B.**:
Тестовете за `fromAssocList` и `toAssocList` разчитат едни на други.

Примери:
```haskell
> fromAssocList []
Node {val = Nothing, children = []}
> fromAssocList [("", 5)]
Node {val = Just 5, children = []}
> fromAssocList [("a", True), ("d", False)]
Node {val = Nothing, children = [('a',Node {val = Just True, children = []}),('d',Node {val = Just False, children = []})]}
> fromAssocList [("a", True), ("as", False), ("ad", True)]
Node {val = Nothing, children = [('a',Node {val = Just True, children = [('s',Node {val = Just False, children = []}),('d',Node {val
 = Just True, children = []})]})]}
```

## 06. (2т.) `toAssocList`

Направете асоциативен списък по подаденото `Trie`:
```haskell
toAssocList :: Trie a -> [(String, a)]
```

Примери:
```haskell
> toAssocList Node {val = Nothing, children = []}
[]
> toAssocList Node {val = Nothing, children = [('a',Node {val = Just True, children = [('s',Node {val = Just False, children = []}), ('d',Node {val = Just True, children = []})]})]}
[("a",True),("as",False),("ad",True)]

> toAssocList $ fromAssocList []
[]
> toAssocList $ fromAssocList [("lol", 5), ("nice", 10)]
[("lol",5),("nice",10)]
> toAssocList $ fromAssocList [("lol", 5), ("nice", 10), ("nic", 3)]
[("lol",5),("nic",3),("nice",10)]
```

## 07. (2т.) `subTrie`

Вземете "под-`Trie`", на даденото, по подаден низ (ключ):
```haskell
subTrie :: String -> Trie a -> Maybe (Trie a)
```

Ключът може и да не присъства, затова връщаме `Maybe`.

Примери:
```haskell
> fmap toAssocList $ subTrie "" $ fromAssocList [("as", 5), ("ad", 10)]
Just [("as",5),("ad",10)]
> fmap toAssocList $ subTrie "a" $ fromAssocList [("as", 5), ("ad", 10)]
Just [("s",5),("d",10)]
> fmap toAssocList $ subTrie "nope" $ fromAssocList [("as", 5), ("ad", 10)]
Nothing
> fmap toAssocList $ subTrie "as" $ fromAssocList [("as", 5), ("ad", 10)]
Just [("",5)]
```
