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

import Prelude hiding ((=<<), forever, (*>) , (<*))
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

-- genWhileEven
-- genRandomN
-- genSatisfying

-- parseUser with decision on first arg
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


-- Maybe are computations that have possible failure.
-- We want to fail the entire computation to fail, if even one fails.
data MyMaybe a
  = MyNothing
  | MyJust a
  deriving Show

instance Functor MyMaybe where
  fmap :: (a -> b) -> MyMaybe a -> MyMaybe b
  fmap = undefined

instance Applicative MyMaybe where
  pure :: a -> MyMaybe a
  pure = undefined

  (<*>) :: MyMaybe (a -> b) -> MyMaybe a -> MyMaybe b
  (<*>) = undefined

instance Monad MyMaybe where
  (>>=) :: MyMaybe a -> (a -> MyMaybe b) -> MyMaybe b
  (>>=) = undefined

data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show

-- actually equivalent to (<*>)!
-- Lift a function from two normal args, to instead work on two effectful args
-- and return a computation.
-- The idea is to consecutively execute them.
-- Use type holes + pure/<$> + (<*>)!
liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 f fx fy = f <$> fx <*> fy

liftA3 :: Applicative f => (a -> b -> c -> d) -> f a -> f b -> f c -> f d
liftA3 = undefined

-- Execute two actions in order, taking only the result of the left one.
-- use type holes, liftA2 and const!
(<*) :: Applicative f => f a -> f b -> f a
(<*) = undefined

-- Execute two actions in order, taking only the result of the right one.
-- use type holes, liftA2 and const!
(*>) :: Applicative f => f a -> f b -> f b
(*>) = undefined

-- Execute all the actions in order in a list which produce an 'a',
-- producing a list of [a]s as a result
sequenceList :: Applicative f => [f a] -> f [a]
sequenceList = undefined

-- Same as above, but for trees.
sequenceTree :: Applicative f => Tree (f a) -> f (Tree a)
sequenceTree = undefined

-- Same as above, but we get a mapping function first.
traverseList :: Applicative f => (a -> f b) -> [a] -> f [b]
traverseList = undefined

traverseTree :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
traverseTree = undefined

-- for loop!
-- This is just traverse, but flipped.
forList :: Applicative f => [a] -> (a -> f b) -> f [b]
forList = undefined

-- Repeat an action a n times, producing a list of results
replicateA :: Applicative f => Int -> f a -> f [a]
replicateA = undefined

-- Repeat an action infinitely
-- (*>) will be useful
forever :: Applicative f => f a -> f b
forever = undefined

-- We execute an action, ignoring its result.
void :: Functor f => f a -> f ()
void = undefined

-- Execute all the actions in a list, ignoring the results
sequenceList_ :: Applicative f => [f a] -> f ()
sequenceList_ = undefined

-- Same as above, but with a mapping function
traverseList_ :: Applicative f => (a -> f b) -> [f a] -> f ()
traverseList_ = undefined

-- conditional execution
-- We want to execute an action, but only when
-- a condition is true.
-- EXAMPLES:
-- > when True $ print 5
-- 5
-- > when False $ print 5
--
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

-- repeat an action while its result evaluates to True
whileM :: Monad m => m Bool -> m ()
whileM = undefined



-- MISC.

intToChar :: Int -> Char
intToChar n = chr $ (+97) $ n `rem` 26

asciiToDigit :: Char -> Int
asciiToDigit c =
  if '0' <= c && c <= '9'
  then fromIntegral $ ord c - ord '0'
  else error $ "You're calling me with a non-number Char:" ++ [c]
