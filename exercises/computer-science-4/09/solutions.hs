
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}      -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}           -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}       -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}           -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}  -- no incomplete patterns in lambdas!

import Prelude hiding (abs, gcd, lcd)

abs :: Int -> Int
abs n
  | n >= 0 = n
  | otherwise = (-n)

-- * но все пак ако разглеждате само 2 случея може да ползвате и if

gcd :: Int -> Int -> Int
gcd n m
  | n > m = gcd (n - m) m
  | n < m = gcd n (m - n)
  | otherwise = n

lcd :: Int -> Int -> Int
lcd n m = n*m `div` gcd n m

apply :: (a -> b) -> a -> b
apply f x = f x

-- (->) е дясно асоциативна, тоест типа на apply можем да го запишем така:
-- apply :: (a -> b) -> (a -> b)
-- id :: a -> a
-- но а е произволен тип, в частност (a -> b)
apply' :: (a -> b) -> a -> b
apply' = id

-- това връща функция защото се прилага частично (x не се подава)
compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)

prefix :: [Int] -> [Int] -> Bool
prefix xs ys = take (length xs) ys == xs

suffix :: [Int] -> [Int] -> Bool
suffix xs ys = drop (length xs) ys == xs

weakListComprehension :: [a] -> (a -> Bool) -> (a -> b) -> [b]
weakListComprehension xs p f = map f (filter p xs)

closed :: [Int] -> (Int -> Int) -> [Int]
closed xs f = filter (\x -> f x `elem` xs) xs

longestIntervalSubset :: [(Float,Float)] -> [(Float,Float)]
longestIntervalSubset xs = filter
                           (< (foldl
                              (\acc x -> if x > acc then x else acc)
                              (0,0)
                              xs))
                           xs

longestIntervalSubset' :: [(Float,Float)] -> [(Float,Float)]
longestIntervalSubset' xs = filter (< (maximum xs)) xs
