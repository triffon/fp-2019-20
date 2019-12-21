import Prelude hiding (any, Maybe, Just, Nothing)

member :: Int -> [Int] -> Bool
member _ [] = False
member e (x:xs)
  |e == x = True
  |otherwise = member e xs

-- member' :: a -> [a] -> Bool
-- Not alright, because the 'a' type can be anything, including types that cannot be compared
-- that's why we include the below restriction on the type parameter 'a'
-- we say that member' works for all types 'a' that can be compared
-- these include Int, String, Char, Bool, [a], etc.
member' :: (Eq a) => a -> [a] -> Bool
member' e (x:xs)
  |e == x = True
  |otherwise = member' e xs

-- A type definition
-- Note that the type 'List' has a type paramter 'a'
-- We can't just have a list. We need a list of some type.
-- e.g. list of strings, list of integers, list of functions, etc.
-- A List (the type on the left) is either constructed with the function Empty
-- denoting an empty list
-- or with the function Cons that takes a value of type 'a' (Int, String, anytype else)
-- and a value of type (List a).
-- Example list: (Cons 1 (Cons 2 (Cons 3 Empty)))
data List a = Empty | Cons a (List a)

-- Notice that here we pose no restrictions on the type a
-- we can measure the length of lists of anything - we don't care
-- what's inside - only how many of it are there.
length' :: List a -> Int
length' Empty = 0
length' (Cons x xs) = 1 + length' xs

map' :: (a -> b) -> List a -> List b
map' _ Empty = Empty
map' f (Cons x xs) = Cons (f x) (map' f xs)

any :: (a -> Bool) -> [a] -> Bool
any _ [] = False
any f (x:xs)
  |f x = True
  |otherwise = any f xs

-- find :: (a -> Bool) -> [a] -> a
-- find _ [] = ???
-- find f xs = head (filter f xs)
-- what happens in the first pattern?
-- what 'a' should we return?
-- should we handle all possible types that the function can be called with?
-- nope.
-- Here we have to deal with a value that is probably missing
-- This is handled by the Maybe type

data Maybe a = Nothing | Just a deriving Show
-- so a Maybe can either have a value (created with the Just constructor)
-- or don't (created with the Nothing constructor)
-- valid Maybe values include Nothing, Just 5, Just "wow", Just (\x -> x + 2)

-- here the types say: we want to find a value, matching a predicate in a list
-- but we keep in mind that it might be missing
find :: (a -> Bool) -> [a] -> Maybe a
find _ [] = Nothing -- Nothing denotes that the value is missing
find f (x:xs)
  |f x = Just x -- Just says that the value exists
  |otherwise = find f xs

-- we can think of Maybe as a box. It's either empty or it has something inside.
-- let's perform functions on Maybe values
--

-- here the return type is also Maybe Int, since
-- we can't be sure that the box passed to the function is full
addTwo :: Maybe Int -> Maybe Int
addTwo Nothing = Nothing -- if the box is empty, there is nothing to add two to
addTwo (Just x) = Just (x + 2) -- writing addTwo (Just x) = x + 2 is wrong since x + 2 is an Int
-- and not Maybe Int. We have to preserve the context of the value possibly missing


-- the idea behind map is that it transforms values with context while preserving the context
-- for lists, the context is the manifold of values inside. Map transforms all values inside
-- and preserves the context by returning a list of the same length
-- The context of maybe is the possible lack of value
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing -- we have nothing to transform. We preserve the context by returning Nothing
mapMaybe f (Just x) = Just (f x) -- we extract the value from the box on the left side
-- and then wrap it again, but transforming it with f first.
-- here we manipulate the value inside the box and put it in a new box afterwards.
-- Note that if we write mapMaybe f x = ... there is no way for us to access the value inside the box
-- we have to deconstruct it via Just
-- we are doing the same for lists with (x:xs)
--
-- this allows us to sequence computations on Maybe values
-- for example (mapMaybe (+ 2) (find even [1..10]))
-- we find the first even number from 1 to 10 and then add 2 to it
-- (mapMaybe (+ 3) (find odd [2,4..10]))
-- we find the first odd number from the even numbers from 2 to 10
-- and then add 3 to it. Since there is no such number, the whole expression
-- returns Nothing





