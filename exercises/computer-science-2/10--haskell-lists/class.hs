{-# OPTIONS_GHC -fwarn-incomplete-patterns #-} -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-} -- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-} -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-} -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- no incomplete patterns in lambdas!

import Prelude hiding (
    gcd, lcm, (.), length, maximum,
    map, filter, foldr, id,
    (<*>))

gcd :: Int -> Int -> Int
gcd a 0 = a
gcd a b = gcd b (a `mod` b)

lcm :: Int -> Int -> Int
lcm a b = (a * b) `div` gcd a b

--template <class T>
--T id (T x) { return x ;}


---- Функции от по-висок ред
id :: a -> a
id x = x

-- композиция на две функции
-- scheme: (define (compose f g)
--           (lambda (x) (f (g x))))
compose :: (a -> b) -> (c -> a) -> c -> b
--compose = \f -> \g -> \x -> f (g x)
compose f g x = f (g x)
--(.) = compose

-- друг вариант за дефиниция на (.)
(.) :: (a -> b) -> (c -> a) -> c -> b
f . g = \x -> f (g x)

-- неподвижна точка
-- scheme: (define (fixpoint? f x) (= x (f x)))
isFixpoint :: Eq a => (a -> a) -> a -> Bool
isFixpoint f x = x == f x

-- производна
-- scheme: (define (derive f dx)
--           (lambda (x)
--             (/ (- (f (+ x dx)) (f x)) dx)))
derive :: (Double -> Double) -> Double -> Double -> Double
derive f dx x = (f (x+dx) - f x) / dx

-- n-то прилагане на функция
-- scheme: (define (repeated f n)
--           (if (= n 0)
--               id
--               (compose f (repeated f (- n 1)))))
repeated :: Int -> (a -> a) -> a -> a
repeated 0 _ = id
repeated n f = f . (repeated (n-1) f)

--repeated 0 _ x = x
--repeated n f x = f (repeated (n-1) f x)
--
--repeated 0 _ = \x -> x
--repeated n f = \x -> f (repeated (n-1) f x)

sqr x = x*x
---- Кортежи
-- (1,2) :: (Int, Int)

-- (,) :: a -> b -> (a,b)
-- fst
-- snd

first :: (a,b,c) -> a
first (x,_,_) = x
second :: (a,b,c) -> b
second (_,y,_) = y
third :: (a,b,c) -> c
third (_,_,z) = z


-- (,,) :: a -> b -> (a,b,c)

-- type Point, Triangle, Vector
type Point = (Double, Double)
type Triangle = (Point, Point, Point)
type Vector = Point
-- <+> <*>
--(1,2) <+> (3,4) ---> (4,6)
(<+>) :: Vector -> Vector -> Vector
(x,y) <+> (z,t) = (x+z,y+t)

(<*>) :: Vector -> Vector -> Vector
(x,y) <*> (z,t) = (x * z, y * t)

---- Списъци
-- [] е списък
-- h:t е списък, ако t е списък

-- [1,2,3,4] == 1:(2:(3:(4:[]))) = 1:2:3:4:[]

-- [1,2,3,4] :: [Int]
-- [1,2,3,4] !! 2 -> 3

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

-- (define (map f l)
--   (if (null? l) l
--       (cons (f (car l)) (map f (cdr l))))

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs) = if p x then x:filter p xs
                         else filter p xs



                         
foldr = undefined

---- Задачки
