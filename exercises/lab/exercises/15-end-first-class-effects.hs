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






--randomTuple :: Random_v1 (Int, Int)
--randomTuple startGen =
--  let (nextGen, n0) = randomInt startGen
--      (lastGen, n1) = randomInt nextGen
--   in (lastGen, (n0, n1))

--type Random_v1 a = Gen -> (Gen, a)

newtype Random a = Random {runRandom :: Gen -> (Gen, a)}

runRandomFinal :: Gen -> Random a -> a
runRandomFinal gen rx = snd $ runRandom rx gen

randomInt' :: Random Int
randomInt' = Random randomInt

randomBool :: Random Bool
randomBool = fmap even randomInt'

instance Functor Random where
  fmap :: (a -> b) -> Random a -> Random b
  fmap f (Random rx) = Random $
    \gen ->
      let (nextGen, x) = rx gen
       in (nextGen, f x)

-- intToChar :: Int -> Char
--randomChar :: Random_v1 Char
--randomChar = applyFunctionOverGen intToChar randomInt
--
--salt :: String -> Random_v1 String
--salt password gen = --applyFunctionOverGen ((password ++) . show) $ randomInt gen
--  let (nextGen, n) = randomInt gen
--   in (nextGen, password ++ show n)

--randomTuple :: Random a -> Random b -> Random (a, b)
--randomTuple rx ry = Random $
--  \gen ->
--    let (nextGen1, x) = runRandom rx gen
--        (nextGen2, y) = runRandom ry nextGen1
--     in (nextGen2, (,) x y)

randomTuple :: Random a -> Random b -> Random (a, b)
randomTuple rx ry = (,) <$> rx <*> ry

randomN :: Int -> Random a -> Random [a]
randomN 0 _ = Random $ \gen -> (gen, [])
randomN n rx = Random $
  \gen ->
    let (nextGen, x) = runRandom rx gen
        (finalGen, xs) = runRandom (randomN (n - 1) rx) nextGen
     in (finalGen, (:) x xs)

-- (<*>) :: Random (b -> c) -> Random b -> Random c
-- (<$>) :: (a -> b) -> Random a -> Random b
--
-- liftA2 :: (a -> b -> [a]) -> Random a -> Random b -> Random [a]
--
-- pure :: a -> Random a
randomN' :: Int -> Random a -> Random [a]
randomN' 0 _ = pure []
randomN' n rx = liftA2 (:) rx (randomN' (n - 1) rx)
--  Random $
--  \gen ->
--    let (nextGen, x) = runRandom rx gen
--        (finalGen, xs) = runRandom (randomN (n - 1) rx) nextGen
--     in (finalGen, (:) x xs)


randomRandom :: Random [Int]
randomRandom = (fmap (`rem` 10) randomInt') `bind` (`randomN'` randomInt')


bind :: Random a -> (a -> Random b) -> Random b
bind rx f = Random $
  \gen ->
    let (nextGen, x) = runRandom rx gen
     in runRandom (f x) nextGen

instance Monad Random where
  (>>=) :: Random a -> (a -> Random b) -> Random b
  rx >>= f = Random $
    \gen ->
      let (nextGen, x) = runRandom rx gen
       in runRandom (f x) nextGen

-- class Monad m where
--   (>>=) :: m a -> (a -> m b) -> m b

randomTuple' :: Random a -> Random b -> Random (a, b)
randomTuple' rx ry = do
  x <- rx
  y <- ry
  pure (x, y)

instance Applicative Random where
  (<*>) :: Random (b -> c) -> Random b -> Random c
  rf <*> rx = Random $
    \gen ->
      let (nextGen, f) = runRandom rf gen
          (nextGen', x) = runRandom rx nextGen
       in (nextGen', f x)

  pure :: a -> Random a
  pure x = Random $ \gen -> (gen, x)

fmap' :: (a -> b) -> Random a -> Random b
fmap' = fmap


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
sequenceList [] = pure []
sequenceList (mx:mxs) = liftA2 (:) mx (sequenceList mxs)

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
forever :: Monad f => f a -> f b
forever mx = do
  mx
  forever mx

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
