{-# LANGUAGE BlockArguments #-}

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- no incomplete patterns in lambdas!
{-# LANGUAGE InstanceSigs #-}                      -- allows us to write signatures in instance declarations


-- ЗАДАЧИ:

data Nat
  = Zero
  | Succ Nat
  deriving Show

-- Имплементирайте нужните функции за да бъде
-- Nat инстанция на класовете Num, Eq, Ord

instance Num Nat where
  fromInteger :: Integer -> Nat
  fromInteger 0 = Zero
  fromInteger n = Succ $ fromInteger $ n - 1
-- Няма нужда да имплементирате долните
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

instance Eq Nat where
  (==) :: Nat -> Nat -> Bool
  Zero == Zero = True
  Succ n == Succ m = n == m
  _ == _ = False
  (/=) :: Nat -> Nat -> Bool
  Zero /= Zero = False
  Succ n /= Succ m = n /= m
  _ /= _ = True

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Ord Nat where
  compare :: Nat -> Nat -> Ordering
  compare Zero Zero = EQ
  compare (Succ _) Zero = GT
  compare Zero (Succ _) = LT
  compare (Succ n) (Succ m) = compare n m
  (<=) :: Nat -> Nat -> Bool
  Succ _ <= Zero = False
  Succ n <= Succ m = n <= m
  _ <= _ = True


-- Реализирайте следните функции:
-- Hint: list comprehension ще ви е полезно в доста от задачите

-- Декартово произведение на 2 произволни списъка
cartesianProduct :: [a] -> [b] -> [(a,b)]
cartesianProduct xs ys = [(x,y) | x<-xs, y<-ys]

-- проверява дали даден списък от списъци е квадратна матрица
isSquareMatrix :: [[a]] -> Bool
isSquareMatrix xss = all ((==size) . length) xss
  where size = length xss

-- намира главния диагонал на матрица
mainDiag :: [[a]] -> [a]
mainDiag [] = []
mainDiag ([]:_) = []
mainDiag ((y:_):xs) = y : mainDiag (map tail xs)

-- намира вторичния диагонал на матрица
secondaryDiag :: [[a]] -> [a]
secondaryDiag = mainDiag . reverse

-- Питагорова тройка е (a,b,c), където a^2 + b^2 = c^2
-- Намерете първите n такива
pythagoreanTriples :: Integral a => Int -> [(a, a, a)]
pythagoreanTriples n
  = take n [(a,b,c) | a<-[1..], b<-[1..a], c<-[1..a], p a b c]
  where p x y z = x^2 == y^2 + z^2

-- Имплементирайте едноименния алгоритъм за сортиране mergeSort
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
  | x < y     = x:(merge xs (y:ys))
  | otherwise = y:(merge (x:xs) ys)

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge firstHalf lastHalf
  where
    firstHalf = mergeSort $ take (length xs `div` 2) xs
    lastHalf = mergeSort $ drop (length xs `div` 2) xs

-- За даден списък xs връща списък от всички негови пермутации
-- Решението е само за списци без повтарящи се елементи
-- (с такива става малко по-сложно)
permutate :: (Eq a) => [a] -> [[a]]
permutate [] = [[]]
permutate xs = [x:ys | x <- xs, ys <- permutate $ filter (/= x) xs]
