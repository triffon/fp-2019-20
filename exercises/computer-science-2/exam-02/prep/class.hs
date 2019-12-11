import Prelude hiding (enumFromTo)
f = f

-- Списъците в Haskell са потоци

--- Генератори на списъци (синтактична захар за enumFrom...)
-- enumFrom n -- безкраен списък на числата от n нататък със стъпка 1
-- [n..] -- синтактична захар
from10  = [10..] -- [10,11,12,13,14,....]
from10' = enumFrom n

-- може също да определим и втория член на списъка
-- enumFromThen n m -- това определя и стъпката
-- [n,m..] -- синтактична захар
evenFrom6  = [6,8..] -- [6,8,10,12,14,16,...]
evenFrom6' = enumFromThen 6 8

-- може да сложим и край
-- enumFromTo n m -- списък от числата между n и m
-- [n..m] -- синтактична захар
digits  = [0..9]
digits' = enumFromTo 0 9

-- може да определим и стъпка и край
-- enumFromThenTo n m k
-- [n,m..k] -- синтактична захар
evenDigits  = [0,2..9]
evenDigits' = enumFromThenTo 0 2 9


--- List comprehension
evenOdds = [ (x,y) | x <- [1..10], y <- [1..10], odd x, even y ]
-- всички двойки (x,y), такива че
-- x е от [1..10], y е от [1..10], x е нечетно и y е четно
-- * всички двойки означава всяко със всяко когато имаме 2 генератора
-- тоест декартово произведение


--- Задача
-- списък от Питагоровите тройки, с числа < 100. Питагорова тройка е наредена тройка (a, b, c), за която a^2 + b^2 = c^2.
pythagoreanTriples = undefined


--------------------------------------------------------------------
-- код от часа

enumFromTo :: Int -> Int -> [Int]
--enumFromTo a b
--  | a > b = []
--  | otherwise = a : enumFromTo (a+1) b

enumFromTo a b =
    if a > b
    then []
    else a : enumFromTo (a+1) b

repeat_ :: a -> [a]
repeat_ x = x : repeat_ x


ones :: [Int]
ones = 1 : ones

type Name = String
type Digit = Int
type FacultyNumber = [Digit]
type Address = String
type StudentRecord =
    (Name, FacultyNumber, Address)

type Vector = (Int, Int)
addVectors :: Vector -> Vector -> Vector
--addVectors u v = (fst u + fst v, snd u + snd v)
addVectors (u1,u2) (v1, v2) =
    (u1+v1,u2+v2)

zipWith' :: (a -> b -> c) ->[a]->[b]->[c]
zipWith' f [] _  = []
zipWith' f _  [] = []
zipWith' f (x:xs) (y:ys) =
    f x y : zipWith' f xs ys

nats :: [Int]
nats = 0 : zipWith (+) ones nats

fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

g :: [a] -> (a, [a], [a])
g rs@(x:xs) = (x, xs, rs)

divides :: Int -> Int -> Bool
divides d n = n `rem` d == 0

sieve :: [Int] -> [Int]
sieve (x:xs) =
    x : sieve (filter (\y-> not (divides x y)) xs)
primes :: [Int]
primes = sieve [2..]
