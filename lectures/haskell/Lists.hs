module Lists where

import Prelude hiding (head, tail, null, length,
                       enumFromTo, enumFromThenTo,
                       (++), reverse, (!!), elem,
                       init, last, take, drop,
                       map, filter, foldr, foldl, foldr1, foldl1,
                       scanr, scanl, zip, unzip, zipWith,
                       takeWhile, dropWhile,
                       any, all)

head :: [a] -> a
head (h:_) = h

tail :: [a] -> [a]
tail (_:t) = t

null :: [a] -> Bool
null [] = True
null _  = False

-- null l = if l == [] then True else False
-- null l = l == []
-- null = (==[])
{-
null l
  | l == []   = True
  | otherwise = False
-}

{-
length :: [a] -> Integer
length []    = 0
length (_:t) = 1 + length t
-}

length :: [a] -> Int
length l = case l of []    -> 0
                     (_:t) -> 1 + length t

enumFromTo a b = enumFromThenTo a (a+1) b
{-  | a > b     = []
  | otherwise = a:enumFromTo (a+1) b-}

enumFromThenTo a0 a1 b
  | a0 > b    = []
  | otherwise = a0:enumFromThenTo a1 (a1 + dx) b
    where dx = a1 - a0

(++) :: [a] -> [a] -> [a]
[]     ++ l = l
(x:xs) ++ l = x : xs ++ l

reverse :: [a] -> [a]
{-
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]
-}
reverse = foldl (flip (:)) []

(!!) :: [a] -> Int -> a
[]    !! _ = error "Опит за извличане на елемент от празен списък"
(x:_) !! 0 = x
(_:t) !! n = t !! (n - 1)

elem :: Eq a => a -> [a] -> Bool
elem _ []     = False
-- elem x (x:xs) = True
-- elem x (y:ys) = elem x ys
elem x (y:ys) = x == y || elem x ys
{-
  | x == y    = True
  | otherwise = elem x ys
-}

pythagoreanTriples a b = [ (x, y, z) | x <- [a..b],
                                       y <- [x+1..b],
                                       z <- [y+1..b],
                                       x^2 + y^2 == z^2 ]

init :: [a] -> [a]
init [_]    = []
init (x:xs) = x:init xs

last :: [a] -> a
last [x]    = x
last (_:xs) = last xs

take :: Int -> [a] -> [a]
take 0 _      = []
take _ []     = []
take n (x:xs) = x : take (n-1) xs

drop :: Int -> [a] -> [a]
drop 0 l      = l
drop _ []     = []
drop n (x:xs) = drop (n-1) xs

map :: (a -> b) -> [a] -> [b]
-- map f l = [ f x | x <- l ]
{-
map _ []     = []
map f (x:xs) = f x : map f xs
-}

filter :: (a -> Bool) -> [a] -> [a]
--filter p l = [ x | x <- l, p x ]
{-
filter _ []     = []
filter p (x:xs)
  | p x       = x : rest
  | otherwise = rest
    where rest = filter p xs
-}
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _  nv []     = nv
foldr op nv (x:xs) = op x (foldr op nv xs)

map f = foldr (\x -> (f x:)) []

filter p = foldr (\x -> if p x then (x:) else id) []

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _  nv []     = nv
foldl op nv (x:xs) = foldl op (op nv x) xs

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 _  [x]    = x
foldr1 op (x:xs) = op x (foldr1 op xs)

foldl1 :: (a -> a -> a) -> [a] -> a
foldl1 op (x:xs) = foldl op x xs 

{-
foldr _  nv []     = nv
foldr op nv (x:xs) = op x (foldr op nv xs)
-}

scanr :: (a -> b -> b) -> b -> [a] -> [b]
{-
scanr _  nv []     = [nv]
scanr op nv (x:xs) = op x r : rs
  where rs@(r:_) = scanr op nv xs
-}

scanr op nv = foldr (\x rs@(r:_) -> op x r : rs) [nv]

scanl :: (b -> a -> b) -> b -> [a] -> [b]
{-
scanl _  nv []     = [nv]
scanl op nv (x:xs) = nv : scanl op (op nv x) xs
-}
scanl op nv = foldl (\rs x -> rs ++ [op (last rs) x]) [nv]

zip :: [a] -> [b] -> [(a,b)]
{-
zip [] _          = []
zip _ []          = []
zip (x:xs) (y:ys) = (x, y) : zip xs ys
-}
unzip :: [(a,b)] -> ([a],[b])
{-
unzip []          = ([], [])
unzip ((x,y):xys) = (x:xs, y:ys)
  where (xs,ys) = unzip xys
-}

unzip = foldr (\(x,y) (xs,ys) -> (x:xs, y:ys)) ([], [])

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _           = []
zipWith _ _ []           = []
zipWith op (x:xs) (y:ys) = op x y : zipWith op xs ys

zip = zipWith (,)

-- zipWith op l1 l2 = map (\(x,y) -> op x y) (zip l1 l2)

-- filter p = foldr (\x xs -> if p x then x:xs else xs) []
-- filter p = foldr (\x -> if p x then (x:) else id) []
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p = foldr (\x -> if p x then (x:) else const []) []

dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ []     = []
dropWhile p l@(x:xs)
 | p x       = dropWhile p xs
 | otherwise = l

any :: (a -> Bool) -> [a] -> Bool
any p l = or (map p l)
