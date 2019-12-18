module Lazy where

import Prelude hiding (enumFrom, enumFromThen, cycle, iterate)

g 1 = 5

{-
False && _ = False
_     && x = x
-}

-- ones = 1 : ones
ones = [1,1..]

enumFrom :: Integer -> [Integer]
enumFrom a = enumFromThen a (a+1)

enumFromThen :: Integer -> Integer -> [Integer]
enumFromThen a0 a1 = a0:enumFromThen a1 (a1 + dx)
    where dx = a1 - a0

cycle :: [a] -> [a]
cycle l = l ++ cycle l

iterate :: (a -> a) -> a -> [a]
iterate f z = z : iterate f (f z)

pairs :: [(Int,Int)]
pairs = concat [ [(x, y),(y, x)] | x <- [0..], y <- [0..x-1] ]

pythagoreanTriples = [ (x, y, z) | z <- [1..], y <- [1..z-1], x <- [1..y-1],
                                   gcd x y == 1, x^2 + y^2 == z^2 ]

powers2 = 1 : zipWith (*) [2,2..] powers2

-- repeated n f x = foldr ($) x (replicate n f)
-- repeated n f = foldr (.) id (replicate n f)
-- repeated n f = foldr (.) id ((replicate n) f)
-- repeated n = foldr (.) id . replicate n
repeated = ((foldr (.) id .) . replicate)

-- f x = f (1 - x)
f x = seq x (f (1 - x))

h p = seq p (head p)
