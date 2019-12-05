import Prelude hiding ((.))
-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-unused-matches #-}
-- write all your toplevel signatures!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- use different names!
--{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- no incomplete patterns in lambdas!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}

square :: Int -> Int
square x = x * x

fib n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fib (n-1) + fib (n-2)

fib' 0 = 0
fib' 1 = 1
fib' n = fib (n-1) + fib (n-2)

-- най-голям общ делител на n и m
-- използвайте div за целочислено делене
gcd' :: Integer -> Integer -> Integer
gcd' n m
  | n == 0 = m
  | m == 0 = n
  | n > m = gcd' m (rem n m)
  | n < m = gcd' n (rem m n)
  | otherwise = n

-- най-малко общо кратно
lcm' :: Integer -> Integer -> Integer
lcm' a b = floor (fromIntegral (a * b) / fromIntegral (gcd' a b))

-- по дадено число намира сбора на цифрите му
sumDigits :: Int -> Int
sumDigits 0 = 0
--sumDigits n = rem n 10 + sumDigits (div n 10)
--
--sumDigits n =
--  let lastDigit = rem n 10
--      restDigits = div n 10
--  in lastDigit + sumDigits restDigits

sumDigits n = lastDigit + sumDigits restDigits
  where lastDigit = rem n 10 
        restDigits = div n 10


---- let и where
-- let е израз; where не е 

-- разстоянието между две точки (x1,y1) и (x2,y2)
dist' :: Double -> Double -> Double -> Double -> Double
dist' x1 y1 x2 y2 = sqrt (square dx + square dy)
  where dx = x1 - x2
        dy = y1 - y2
        square x = x * x


-- let и where имат блокове с дефиниции, които зависят от идентацията
area x1 y1 x2 y2 x3 y3 =
  let a = dist x1 y1 x2 y2
      p = (a + b + c) / 2
      b = dist x2 y2 x3 y3
      c = dist x3 y3 x1 y1
   in sqrt (p * (p - a) * (p - b) * (p - c))
  where dist u1 v1 u2 v2 = sqrt (du^2 + dv^2)
         where du = u2 - u1
               dv = v2 - v1

-- следното би било грешно
---- let a = 5
----    b = 7
----  in a + b
-- защото a и b трябва да са едно под друго

---- Оператори
-- Операторите в хаскел винаги са бинарни, освен -
-- Всяка функция на поне 2 аргумента можем да я използваме като оператор, обграждайки я в ``
-- 12 `mod` 3
-- 243 `div` 10

-- Също така всеки оператор можем да го използваме като функция:
-- (+) 2 3

-- Можем да си дефинираме оператори
(+*) :: Int -> Int -> Int
x +* y = (x + y) * y
--(+*) x y = (x + y) * y


x /&-^# y  = x / (x - y)

-- Операторите, като функциите, може да се прилагат частично
-- (+5) (10-) (`mod`3)

---- Ламбда функции
-- \ arg -> expr
-- Пример:
square' = \x -> x * x

---- Функции от по-висок ред
-- (->) е дясно асоциативна, значи следните два реда означават едно и също:
-- plus :: Int -> Int -> Int
-- plus :: Int -> Int -> (Int -> Int)

-- plus 1 2
-- което е същото като
-- (plus 1) 2
--
plus :: Int -> (Int -> (Int -> Int))
-- следните две дефиниции правят едно и също нещо
plus x y z = x + y + z
plus = \x -> \y -> \z -> x + y + z

---- Функции от по-висок ред
-- композиция на две функции
-- scheme: (define (compose f g)
--           (lambda (x) (f (g x))))

--compose :: 
--compose = \f -> \g -> \x -> f (g x)
compose f g x = f (g x)
(.) = compose

-- друг вариант за дефиниция на (.)
f . g = \x -> f (g x)
