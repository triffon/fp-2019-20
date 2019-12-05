{-# OPTIONS_GHC -fwarn-incomplete-patterns #-} -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-} -- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-} -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-} -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- no incomplete patterns in lambdas!

import Prelude hiding (gcd, lcm, (.), length, maximum, map, filter, foldr, id)

gcd :: Int -> Int -> Int
gcd a 0 = a
gcd a b = gcd b (a `mod` b)

lcm :: Int -> Int -> Int
lcm a b = (a * b) `div` gcd a b

---- Функции от по-висок ред
id = undefined

-- композиция на две функции
-- scheme: (define (compose f g)
--           (lambda (x) (f (g x))))
--compose :: 
--compose = \f -> \g -> \x -> f (g x)
compose f g x = f (g x)
(.) = compose

-- друг вариант за дефиниция на (.)
f . g = \x -> f (g x)

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
-- [1,2,3,4] !! 2 -> 3

length = undefined

map = undefined
filter = undefined

foldr = undefined

---- Задачки
