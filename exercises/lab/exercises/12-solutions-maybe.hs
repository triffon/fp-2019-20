{-# LANGUAGE InstanceSigs #-} -- allows us to write signatures in instance declarations

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Maybe(..), maybe, lookup)

import Data.Monoid (Sum(..))

data Maybe a
  = Nothing
  | Just a
  deriving Show

-- EXERCISE: Equality on Maybes
-- Lift equality
instance (Eq a) => Eq (Maybe a) where
  Nothing == Nothing = True
  Just x == Just y = x == y
  _ == _ = False

-- EXERCISE: Deconstruct a list if possible
--
-- EXAMPLES:
-- safeUncons [] == Nothing
-- safeUncons [10,13,12] == Just (10, [13,12])
safeUncons :: [a] -> Maybe (a, [a])
safeUncons [] = Nothing
safeUncons (x:xs) = Just (x, xs)

-- EXERCISE: Safe integer division
-- We can't divide by 0, so we don't always return a result.
-- Return both the quotient and the remainder
safeDiv :: Int -> Int -> Maybe (Int, Int)
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y, x `rem` y)

-- EXERCISE: Strip a prefix from a string
-- But the second string doesn't always contain the first as a prefix,
-- so we want to be able to fail.
--
-- EXAMPLES:
-- stripPrefix "foo" "foobar" == Just "bar"
-- stripPrefix "mgla" "kpop" == Nothing
stripPrefix :: String -> String -> Maybe String
stripPrefix "" str = Just str
stripPrefix _ "" = Nothing
stripPrefix (x:xs) (y:ys)
  | x == y = stripPrefix xs ys
  | otherwise = Nothing

-- EXERCISE: Lookup in an associative list
--
-- EXAMPLES:
-- lookup 5 [(10, 'a'), (5,'c')] == Just 'c'
-- lookup 13 [(10, 'a'), (5,'c')] == Nothing
lookup :: Eq k => k -> [(k, v)] -> Maybe v
lookup k = mapMaybe snd . listToMaybe . filter ((==k) . fst)

-- EXERCISE: Fallback
--
-- EXAMPLES:
-- fromMaybe 5 Nothing == 5
-- fromMaybe 5 (Just 10) == 10
fromMaybe :: a -> Maybe a -> a
fromMaybe def Nothing = def
fromMaybe _ (Just x) = x

-- EXERCISE: Total deconstruction of a Maybe
-- Sometimes useful instead of pattern matching
-- or with higher order functions
--
-- EXAMPLES:
-- maybe 5 succ (Just 10) == 11
-- maybe 5 succ Nothing == 5
maybe :: b -> (a -> b) -> Maybe a -> b
maybe def _ Nothing = def
maybe _ f (Just x) = f x

-- EXERCISE: Convert a maybe to a list
maybeToList :: Maybe a -> [a]
maybeToList = foldMapMaybe (:[])

-- EXERCISE: Keep the first element of a list, if there are any
listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x

-- EXERCISE: Sum all the values inside the maybe
--
-- EXAMPLES:
-- sumMaybe Nothing == 0
-- sumMaybe (Just 5) == 5
sumMaybe :: Num a => Maybe a -> a
sumMaybe = getSum . foldMapMaybe Sum
           -- ^ imported from Data.Monoid

-- EXERCISE: Apply a function on a value, if there is any
-- Note that this function in base does a different thing!
--
-- EXAMPLES:
-- mapMaybe succ Nothing == Nothing
-- mapMaybe succ (Just 41) == Just 42
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing
mapMaybe f (Just x) = Just $ f x

-- EXERCISE: Folding a Maybe
--
-- EXAMPLES:
-- foldMaybe (Just [1,2,3]) == [1,2,3]
-- foldMaybe (Nothing :: Maybe [Int]) == []
foldMaybe :: Monoid a => Maybe a -> a
foldMaybe = foldMapMaybe id

-- EXERCISE: Analogue of foldMap for lists
foldMapMaybe :: Monoid b => (a -> b) -> Maybe a -> b
foldMapMaybe f = foldMaybe . mapMaybe f

-- EXERCISE: Get all the Justs from a list
--
-- EXAMPLES:
-- catMaybes [Just 5, Nothing, Just 10] == [5, 10]
catMaybes :: [Maybe a] -> [a]
catMaybes xs = [x | Just x <- xs]
--catMaybes = concatMap maybeToList

-- EXERCISE : Map all the values of a list with possible failure
-- and get back all the successful results
--
-- This is what Data.Maybe.mapMaybe does.
-- Contrast this with filter!
--
-- mapListMaybe safeUncons [[], [1,2], [], [2,3]] == [(1, [2]), (2, [3])]
mapListMaybe :: (a -> Maybe b) -> [a] -> [b]
mapListMaybe f = catMaybes . map f

-- EXERCISE: "Adapter" to convert (a -> Bool) functions to Maybe returning ones
--
-- EXAMPLES:
-- (onBool even) 3 == Nothing
-- (onBool even) 4 == Just 4
onBool :: (a -> Bool) -> a -> Maybe a
onBool f x =
  if f x
  then Just $ x
  else Nothing

-- EXERCISE: Conditional execution
--
-- (note how this looks like flip concatMap :: [a] -> (a -> [b]) -> [b] !)
--
-- The idea is that, if at any point one of our computations returns a Nothing,
-- we fail the whole thing early.
--
-- EXAMPLES:
-- xs == [(2, "k"), (3, "e"), (42, "k")]
-- x = lookup 2 xs `ifJust` (\x ->
--     lookup 3 xs `ifJust` (\y ->
--     lookup 42 xs `ifJust` (\z ->
--     Just $ x ++ y ++ z)))
-- x == Just "kek"
--
-- xs == [(13, "k"), (3, "e"), (42, "k")]
-- x = lookup 2 xs `ifJust` (\x ->
--     lookup 3 xs `ifJust` (\y ->
--     lookup 42 xs `ifJust` (\z ->
--     Just $ x ++ y ++ z)))
-- x == Nothing
ifJust :: Maybe a -> (a -> Maybe b) -> Maybe b
ifJust Nothing _ = Nothing -- note how we don't look at the f at all
ifJust (Just x) f = f x

-- Induced Semigroup by a
instance Semigroup a => Semigroup (Maybe a) where
  (<>) :: Maybe a -> Maybe a -> Maybe a
  Nothing <> x = x
  x <> Nothing = x
  Just x <> Just y = Just $ x <> y

-- Maybe lifts any Semigroup to a Monoid!
instance Semigroup a => Monoid (Maybe a) where
  mempty :: Maybe a
  mempty = Nothing
