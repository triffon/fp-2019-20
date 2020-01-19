{-# LANGUAGE InstanceSigs #-}

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- TODO: explain random number generators
-- * the concept of PRNG
-- TODO: (explain <> install) random
-- * StdGen (+ how it's printed)
-- * random, the function
-- TODO: random
-- * randomInt
-- * StdGen -> a
-- * StdGen -> (StdGen, a)
--
-- TODO: DON'T BE IN A RUSH!!!!!

import Prelude hiding ((=<<))
import Random (Gen, randomInt, theGen)
import Data.Char (chr, ord)

randomBool :: Gen -> (Gen, Bool)
randomBool gen =
  let (nextGen, n) = randomInt gen
   in (nextGen, even n)

randomChar :: Gen -> (Gen, Char)
randomChar gen =
  let (nextGen, n) = randomInt gen
   in (nextGen, intToChar n)

salt :: String -> Gen -> (Gen, String)
salt password gen =
  let (nextGen, n) = randomInt gen
   in (nextGen, password ++ show n)

-- TODO
-- type Random

-- TODO: explain parsers
-- * String -> Maybe a
-- * String -> Maybe (String, a) + newtype
-- * write some by hand

nom :: String -> Maybe Char
nom = undefined

-- TODO
-- type Parser
-- * runParser

--asdfParser :: Parser String

-- TODO:
-- data Student
-- genStudent
-- genPair
-- genN

-- parseStudent
-- parsePair
-- parseN

-- Applicative

--class Applicative f where
--  pure :: a -> f a
--  (<*>) :: f (a -> b) -> f a -> f b
-- laws are scary looking, so not showing them

-- genRandomN
-- genSatisfying

-- parseParseN
-- parseSatisfying

-- Monad
--class Monad f where
--  (>>=) :: f a -> (a -> f b) -> f b

-- some laws:
--
-- pure x >>= f == f x
-- (inserting a value into a context and then binding it to a function is the same
-- as just directly using the function on the original pure value
-- this effectively means that pure should not introduce any side effects!)
-- mx >>= pure == mx
-- (binding a value and then purely inserting it back does nothing)
-- mx >>= pure . f == fmap f mx
-- (binding a value to only apply a function to it and then purely inserting it back
-- is the same as just fmap-ing, as you aren't doing any additional effects)
-- m >>= (\x -> k x >>= h) == (m >>= k) >>= h
-- ((>>=) is associative, in some sense of hte word)
--

data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show

-- actually equivalent to (<*>)!
liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 = undefined

liftA3 :: Applicative f => (a -> b -> c -> d) -> f a -> f b -> f c -> f d
liftA3 = undefined

sequenceList :: Applicative f => [f a] -> f [a]
sequenceList = undefined

sequenceTree :: Applicative f => Tree (f a) -> f (Tree a)
sequenceTree = undefined

traverseList :: Applicative f => (a -> f b) -> [a] -> f [b]
traverseList = undefined

traverseTree :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
traverseTree = undefined

-- for loop!
-- flip traverse
forList :: Applicative f => [a] -> (a -> f b) -> f [b]
forList = undefined

void :: Functor f => f a -> f ()
void = undefined

sequenceList_ :: Applicative f => [f a] -> f ()
sequenceList_ = undefined

replicateA :: Applicative f => f a -> f [a]
replicateA = undefined

-- conditional execution
when :: Applicative f => Bool -> f () -> f ()
when = undefined

-- note how this is like
-- ($) ::           (a ->   b) ->   a ->   b
-- but for effectful computations!
(=<<) :: Monad m => (a -> m b) -> m a -> m b
(=<<) = undefined

-- note how this is like
-- (.) ::           (b ->   c) -> (a ->   b) -> a ->   c
-- but for effectful computations!
(<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
(<=<) = undefined

-- these two "fish operators" are equivalent to (>>=)!
-- here are the laws using this way more sane thing:
-- (f >=> g) >=> h == f >=> (g >=> h)
-- (associativity)
-- pure >=> f == f == f >=> pure
-- (pure is a neutral element for (>=>))
(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
(>=>) = undefined

-- Monad implies Applicative
ap :: Monad m => m (a -> b) -> m a -> m b
ap = undefined

-- use holes!
join :: Monad m => m (m a) -> m a
join = undefined

-- join is equivalent to (>>=)!
-- only use fmap and join here!
bindWithJoin :: Monad m => m a -> (a -> m b) -> m b
bindWithJoin = undefined

--nNumbers :: Int -> StdGen -> (StdGen, [Int])
--nNumbers 0 lastStdGen = (lastStdGen, [])
--nNumbers n seed =
--  let (nextStdGen, randomNumber) = next seed
--      (lastStdGen, numbers) = nNumbers (n - 1) nextStdGen
--   in (lastStdGen, randomNumber : numbers)
--
--num :: Randomness Int
--num = Randomness next
--
--saltR :: String -> Randomness String
--saltR password = Randomness $
--  \seed -> let (nextStdGen, randomNumber) = next seed
--            in (nextStdGen, password ++ show randomNumber)
--
--instance Functor Randomness where
--  fmap f randomA = Randomness $ \seed ->
--    let g = runRandomness randomA
--        (newStdGen, a) = g seed
--     in (newStdGen, f a)
--
---- applicative
---- why fmap doesn't work (need to "lift twice")
---- what more do we need
--genPair :: Randomness a -> Randomness b -> Randomness (a, b)
--genPair genA genB = Randomness $ \seed ->
--  let (newStdGen, x) = runRandomness genA seed
--      (lastStdGen, y) = runRandomness genB newStdGen
--   in (lastStdGen, (,) x y)
--
--multRandomN :: Int -> Randomness Int
--multRandomN 0 = Randomness $ \seed -> (seed, 1)
--multRandomN n = Randomness $ \seed ->
--  let (newStdGen, number) = runRandomness num seed
--      (lastStdGen, rest) = runRandomness (multRandomN (n - 1)) newStdGen
--   in (lastStdGen, number * rest)
--
--genRandomN :: Randomness a -> Int -> Randomness [a]
--genRandomN genOne 0 = Randomness $ \seed -> (seed, [])
--genRandomN genOne n = Randomness $ \seed ->
--  let (newStdGen, a) = runRandomness genOne seed
--      (lastStdGen, as) = runRandomness (genRandomN genOne (n - 1)) newStdGen
--   in (lastStdGen, a:as)
--
--noAction :: a -> Randomness a
--noAction x = Randomness $ \seed -> (seed, x)
--
--lift2 :: (a -> b -> c) -> Randomness a -> Randomness b -> Randomness c
--lift2 = undefined
--
---- using liftA2
--lift3 :: (a -> b -> c -> d) -> Randomness a -> Randomness b -> Randomness c -> Randomness d
--lift3 = undefined
--
--splat :: Randomness (a -> b) -> Randomness a -> Randomness b
--splat = undefined
--
---- using splat
--lift3' :: (a -> b -> c -> d) -> Randomness a -> Randomness b -> Randomness c -> Randomness d
--lift3' = undefined
--
---- monad???
---- why splat doesn't work (conditional execution)
---- what more do we need
--genRandom :: Randomness a -> Randomness [a]
--genRandom genOne = Randomness $ \seed ->
--  let (newStdGen, n) = runRandomness num seed
--   in runRandomness (genRandomN genOne n) newStdGen
--
--numPredicate :: (Int -> Bool) -> Randomness Int
--numPredicate p = Randomness $ \seed ->
--  let (newStdGen, n) = runRandomness num seed
--   in if p n
--      then (newStdGen, n)
--      else runRandomness (numPredicate p) newStdGen
--
--using :: (a -> Randomness b) -> Randomness a -> Randomness b
--using randomnessF ra = Randomness $ \seed ->
--  let (newStdGen, a) = runRandomness ra seed
--   in runRandomness (randomnessF a) newStdGen

intToChar :: Int -> Char
intToChar n = chr $ (+97) $ n `rem` 26

asciiToDigit :: Char -> Int
asciiToDigit c =
  if '0' <= c && c <= '9'
  then fromIntegral $ ord c - ord '0'
  else error $ "You're calling me with a non-number Char:" ++ [c]
