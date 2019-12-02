{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}      -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}           -- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-}       -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}           -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}  -- no incomplete patterns in lambdas!


---- let и where
-- let е израз
-- where не е 

-- разстоянието между две точки (x1,x2) и (y1,y2)
dist x1 x2 y1 y2 = undefined




area x1 y1 x2 y2 x3 y3 =
  let  a = dist x1 y1 x2 y2
       b = dist x2 y2 x3 y3
       c = dist x3 y3 x1 y1
       p = (a + b + c) / 2
  in sqrt (p * (p - a) * (p - b) * (p - c))
  where dist u1 v1 u2 v2 = sqrt (du^2 + dv^2)
         where du = u2 - u1
               dv = v2 - v1

---- Оператори
-- Операторите в хаскел винаги са бинарни, освен -
-- Всяка функция на поне 2 аргумента можем да я използваме като оператор, обграждайки я в ``
-- 12 `mod` 3
-- 243 `div` 10

-- Също така всеки оператор можем да го използваме като функция:
-- (+) 2 3

-- Можем да си дефинираме оператори
(+*) :: Int -> Int -> Int
x +* y  = (x + y) * y
-- същото като
--(+*) x y  = (x + y) * y

x /&-^# y  = x / (x - y)

-- Операторите, като функциите, може да се прилагат частично
-- (+5) (10-) (`mod`3)


---- Функции от по-висок ред
-- (->) е дясно асоциативна, значи следните два реда означават едно и също:
-- plus :: Int -> Int -> Int
-- plus :: Int -> (Int -> Int)

-- plus 1 2
-- което е същото като
-- (plus 1) 2

---- Ламбда функции
-- \ arg -> expr
-- Пример:
-- square = \x -> x * x

---- Функции от по-висок ред
-- композиция на две функции
-- scheme: (define (compose f g)
--           (lambda (x) (f (g x))))
compose = undefined
(.) = undefined

-- неподвижна точка
-- scheme: (define (fixpoint? f x) (= x (f x)))
isFixpoint = undefined

-- производна
-- scheme: (define (derive f dx)
--           (lambda (x) (/ (- (f (+ x dx)) (f x)) dx)))
derive = undefined

-- n-то прилагане на функция
-- scheme: (define (repeated f n)
--           (if (= n 0)
--               id
--               (compose f (repeated f (- n 1)))))
repeated = undefined

---- Кортежи
-- (1,2) :: (Int, Int)

-- (,) :: a -> b -> (a,b)
-- fst
-- snd

-- (,,) :: a -> b -> (a,b,c)

-- type Point, Triangle, Vector
-- <+> <*>

---- Списъци
-- [] е списък
-- h:t е списък, ако t е списък

-- [1,2,3,4] == 1:2:3:4:[]

-- [1,2,3,4] :: [Int]


---- Задачки

-- * Решете задачите със списъци без рекурсия,
-- само с готови конструкции за работа със списъци


-- намира дължина на списък
length' = undefined

-- намира максималния елемент в списък
maximum' = undefined

-- проверява дали първия списък е префикс на втория
-- Списъците са само от числа
isPrefix = undefined

-- проверява дали първия списък е суфикс на втория
-- Списъците са само от числа
isSuffix = undefined

-- по дадени списък xs, предикат p и функция f
-- връща списък от елементите на xs, за които е изпълнен предиката p,
-- като над тези елементи е приложена функцията f.
weakListComprehension = undefined

-- по даден списък xs и функция f
-- връща списък от тези елементи x на xs, за които f(x) е от xs
closed = undefined

-- По даден списък от двойки (интервали) (a,b), връща списък
-- от всички подинтервали на най-дългият интервал
longestIntervalSubset = undefined
