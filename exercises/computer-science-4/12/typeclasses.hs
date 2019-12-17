{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- no incomplete patterns in lambdas!
{-# LANGUAGE InstanceSigs #-}                      -- allows us to write signatures in instance declarations

-- Една конструцият която не съм ви показал е
-- case <expr> of {<case-match>}+
fib :: Int -> Int
fib n = case n of
          0 -> 1
          1 -> 1
          m -> fib (m - 1) + fib (m - 2)

-- Всъщност pattern matching-а е синтактична захар
-- за разглеждане на случаи

-- Няколко полезни оператора/функции
-- flip :: (a -> b) -> b -> a
-- За дадена функция на 2 аргумента връща нова функция,
-- но с обърнат ред на аргументите

-- ($) - апликация, тя е с най-нисък приоритет (тоест ще се изпълни последна)
-- Пример: Искаме да вземем първите n прости числа на квадрат
-- take n (map (^2) (filter prime [2..]))
-- take n $ map (^2) $ filter prime [2..]

-- (.) - композиция
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- Пример: отрицание на предикат
-- complement p = (\x -> not $ p x)
-- complement p x = not $ p x
-- complement p = not . p

-- TODO: pointfree


-- TYPECLASSES

-- Нека разгледаме първо някой полиморфични функции над списъци
-- reverse :: [a] -> [a]
-- length :: [a] -> [a]
-- head :: [a] -> a
-- Тези функции могат да работят с елементи от произволен тип
-- Още повече те не се интересуват от самите елементи
-- (a е типова променлива)
-- Това се нарича параметричен полиморфизъм
-- ([] е полиморфна константа)

-- Ето една имплементация на quicksort за числа
-- Какво обаче ако искаме да работи и за елементи от друг тип
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (x:xs) = quicksort lower ++ [x] ++ quicksort higher
  where lower = [y | y<-xs, y <= x]
        higher = [y | y<-xs, y > x]

-- Аз миналия път се бях изпуснал  и бях дал
-- декларация в която имаше "Ord a"
-- quicksort :: Ord a => [a] -> [a]

-- "Ord a" казва че тези елементи от типа a
-- трябва да можем да ги сравняваме
-- Нарича се class constraint (класово ограничение)
-- Това е различен тип полиморфизъм (ad-hoc),
-- той изисква някакви допълнителни свойства от елементите

-- Ord е типов клас, НЕ клас като тези в ООП
-- TODO: типови калсове като множества/предикати/интерфейси

-- TODO: Списъка е полиморфна константа
-- TODO: Числата са полиморфни константи

-- Инстанция на типов клас наричаме всеки тип,
-- за който са реализирани операциите зададени в класа.
-- Тези операции наричаме методи на съответния клас.
-- Нека видим как можем да направим някой тип инстанция на някой клас.

data Parity
  = Even
  | Odd
  deriving Show

-- Show е типов клас, чйито инстанции могат да бъдат
-- извеждани на екрана
-- deriving казва на Haskell да се опита да генерира нужните функции,
-- за да бъде типа инстанция на изброените класове

-- Нека разгледаме няколко основни класа - Num, Eq, Ord
-- И ще видим как да направим Parity тяхна инстанция

-- TODO: флаг за декларации

-- Num
-- За да можем да кастваме числа към Parity
-- ни стига да имплементираме fromIntegral
instance Num Parity where
  fromInteger :: Integer -> Parity
  fromInteger n = case n `mod` 2 of
                    0 -> Even
                    _ -> Odd
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined


-- Eq
-- Достатъчно е да се имплементира поне едно от: (==), (/=)
-- Защото могат да се имплементират взаимно
instance Eq Parity where
  (==) :: Parity -> Parity -> Bool
  Odd  == Odd  = True
  Even == Even = True
  _    == _    = False
  (/=) :: Parity -> Parity -> Bool
  Even /= Odd  = True
  Odd  /= Even = True
  _    /= _    = False

-- Закони за Eq (еквивалентност):
-- За всяко x y z
-- x == x
-- x == y -> y == x
-- x == y && y == z -> x == z


-- Ord
-- Достатъчно е да се имплементира едно от: compare, (<=)
-- Защото могат да се имплементират взаимно
-- compare връща Ordering, а то има следната дефиниция:
-- data Ordering = LT | EQ | GT

-- Можем да ги имплементираме с идеята че,
-- Even е като 0
-- Odd е като 1
-- Заради остатъците при делене на 2
instance Ord Parity where
  compare :: Parity -> Parity -> Ordering
  compare Odd Even = LT
  compare Even Odd = GT
  compare _ _ = EQ
  (<=) :: Parity -> Parity -> Bool
  Odd <= Even = False
  _ <= _ = True

-- Закони за Ord (частична наредба):
-- За всяко x y z
-- x <= x
-- x <= y && y <= x -> x == y
-- x <= y && y <= z -> x <= z


-- ЗАДАЧИ:

data Nat
  = Zero
  | Succ Nat
  deriving Show

-- Имплементирайте нужните функции за да бъде
-- Nat инстанция на класовете Num, Eq, Ord

instance Num Nat where
  fromInteger :: Integer -> Nat
  fromInteger = undefined
-- Няма нужда да имплементирате долните
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

instance Eq Nat where
  (==) :: Nat -> Nat -> Bool
  (==) = undefined
  (/=) :: Nat -> Nat -> Bool
  (/=) = undefined

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Ord Nat where
  compare :: Nat -> Nat -> Ordering
  compare = undefined
  (<=) :: Nat -> Nat -> Bool
  (<=) = undefined


-- Реализирайте следните функции:
-- Hint: list comprehension ще ви е полезно в доста от задачите

-- Имплементирайте едноименния алгоритъм за сортиране mergeSort
mergeSort :: Ord a => [a] -> [a]
mergeSort = undefined

-- Декартово произведение на 2 произволни списъка
cartesianProduct :: [a] -> [b] -> [(a,b)]
cartesianProduct = undefined

-- проверява дали даден списък от списъци е квадратна матрица
isSquareMatrix :: [[a]] -> Bool
isSquareMatrix = undefined

-- намира главния диагонал на матрица
mainDiag :: [[a]] -> [a]
mainDiag = undefined

-- намира вторичния диагонал на матрица
secondaryDiag :: [[a]] -> [a]
secondaryDiag = undefined

-- Питагорова тройка е (a,b,c), където a^2 + b^2 = c^2
-- Намерете първите n такива
pythagoreanTriples :: Integral a => a -> [(a, a, a)]
pythagoreanTriples = undefined

-- За даден списък xs връща списък от всички негови пермутации
permutations :: [a] -> [[a]]
permutations = undefined

