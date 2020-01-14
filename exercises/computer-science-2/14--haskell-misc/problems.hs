{-# LANGUAGE InstanceSigs #-} -- allows us to write signatures in instance declarations

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- Връща списък от всички подмасиви на даден списък
--
-- subarrays [1,2,3] == [[], [1],[2],[3], [1,2],[2,3], [1,2,3]]
subarrays :: [a] -> [[a]]
subarrays = undefined

-- Връща списък от всички подредици на даден списък.
-- Каква е разликата с subarrays и subsets?
--
-- subsequnces [1,2,3] == [[], [1],[2],[3], [1,2],[1,3],[2,3], [1,2,3]]
subsequences :: [a] -> [[a]]
subsequences = undefined

-- връща списък от всички пермутации на даден списък
--
-- permutations [1,2,3] == [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
permutations :: [a] -> [[a]]
permutations = undefined

-- combinations k xs = списък от всички комбинации на n елемента k-ти клас (не ни интересува наредба)
--
-- ако имаме xs = [1,2,3,4,5]
-- то сред комбинациите му от 3ти клас,
-- [2,4,5] и [4,2,5] се водят една и съща комбинация,
-- затова само едното от двете ще се срещне в резултата от функцията.
--
-- combinations 2 [1,2,3] == [[1,2],[2,3],[1,3]]
combinations :: Int -> [a] -> [[a]]
combinations = undefined

-- variations k xs = списък от всички вариации на n елемента k-ти клас (интересува ни наредбата)
--
-- за списъка xs = [1,2,3,4,5]
-- [2,4,5] и [4,2,5] са различни вариации,
-- затова и двете ще се срещнат в резултата от функцията.
--
-- variations 2 [1,2,3] == [[1,2],[2,1],[2,3],[3,2],[1,3],[3,1]]
variations :: Int -> [a] -> [[a]]
variations = undefined


data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving (Eq, Show)

-- Проверява дали двоично дърво е наредено
isBST :: Ord a => Tree a -> Bool
isBST = undefined

-- Имплементацията на isBST е малка неприятна.
-- Може да използваме следния тип, за да ни помогне.

-- Идеята на този тип е да обогатим наредбата в `a`,
-- като добавим специален елемент, по-малък от всички останали (Bot)
-- и по-голям от всички останали (Bot)
data BotTop a = Bot | Val a | Top
  deriving (Show, Eq{-, Ord-})
-- Автоматично генерираната инстанция на Ord прави точно това
instance Ord a => Ord BotTop where
  compare :: BotTop a -> BotTop a -> Ordering
  compare Bot     Bot     = EQ
  compare Bot     _       = LT
  compare (Val x) (Val y) = compare x y
  compare Top     Top     = EQ
  comapre _       _       = GT

-- Сега ако имплементираме следната функция
-- която проверява дали дадено дърво е между подадените граници
between :: Ord a => BotTop a -> BotTop a -> Tree a -> Bool
between = undefined

-- то имплементацията на isBST става просто:
--isBST = between Bot Top

-- Примери:
-- > between (Val 0) (Val 10) $ Node 8 (Node 6 Empty Empty) Empty
-- True
--
-- > between (Val 0) (Val 5) $ Node 8 (Node 6 Empty Empty) Empty
-- False
--
-- > between (Val 7) (Val 10) $ Node 8 (Node 6 Empty Empty) Empty
-- False
