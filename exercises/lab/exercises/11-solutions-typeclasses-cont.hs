{-# LANGUAGE InstanceSigs #-} -- allows us to write signatures in instance declarations

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Semigroup(..), Monoid(..), foldMap, all, any)

-- REMINDER:

--class Eq a where -- == or /=
--  (==) :: a -> a -> Bool
--  x == y = not (x /= y)
--  (/=) :: a -> a -> Bool
--  x /= y = not (x == y)
--
-- Eq laws
-- for all x y z:
-- reflexivity - x == x
-- symmetry -  x == y -> y == x
-- transitivity - x == y && y == z -> x == z

--class Eq a => Ord a where -- <= or compare
--  compare :: a -> a -> Ordering
--  compare x y
--    | x == y = EQ
--    | x <= y = LT
--    | otherwise = GT
--  (<=) :: a -> a -> Bool
--  x <= y = case compare x y of
--            LT -> True
--            EQ -> True
--            GT -> False
--
--  Ord laws - should probably be a partial order
--  for all x y z:
--  reflexivity - x <= x
--  antisymmetry - x <= y & y <= x -> x == y
--  transitivity - x <= y & y <= z -> x <= z

class Monoid a where
  zero :: a
  (<>) :: a -> a -> a
-- Monoid laws:
-- for all x y z:
-- zero is identity - zero <> x == x == x <> zero
-- (<>) is associative - (x <> y) <> z == x <> (y <> z)

infixr 6 <>

-- Resource on typeclasses:
-- https://wiki.haskell.org/Typeclassopedia


-- Ints as a Monoid under addition
-- N, 0, +
newtype Add = Add Int

getAdd :: Add -> Int
getAdd (Add x) = x

instance Monoid Add where
  zero :: Add
  zero = Add 0
  (<>) :: Add -> Add -> Add
  (<>) (Add x) (Add y) = Add (x + y)

-- Ints as a Monoid under multiplication
-- N, 1, *
newtype Mult = Mult Int

getMult :: Mult -> Int
getMult (Mult x) = x

instance Monoid Mult where
  zero :: Mult
  zero = Mult 1
  (<>) :: Mult -> Mult -> Mult
  (<>) (Mult x) (Mult y) = Mult (x * y)

-- Use Naught instead of Zero so we can use Zero for bits
data Nat = Naught | Succ Nat
  deriving Show

-- partial, but convenient instance of Num for Nat
-- so we can write number literals to mean Nat numbers
-- @fromInteger@ is the convenient bit
instance Num Nat where
  fromInteger :: Integer -> Nat
  fromInteger 0 = Naught
  fromInteger n = Succ $ fromInteger $ n - 1
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

-- EXERCISE: Equality for Nats
instance Eq Nat where
  (==) :: Nat -> Nat -> Bool
  Naught == Naught = True
  Succ n == Succ m = n == m
  _ == _ = False

-- EXERCISE: Ordering for Nats
instance Ord Nat where
  (<=) :: Nat -> Nat -> Bool
  Naught <= _ = True
  _ <= Naught = False
  Succ n <= Succ m = n <= m

-- EXERCISE: Addition on Nats
-- EXAMPLES:
-- 0 <> 13 = 13
-- 5 <> 10 == 15
instance Monoid Nat where
  zero :: Nat
  zero = Naught
  (<>) :: Nat -> Nat -> Nat
  Naught <> m = m
  Succ n <> m = Succ $ n <> m

-- EXERCISE: Appending lists
-- EXAMPLES:
-- [1,2,3] <> [] == [1,2,3]
-- [1,2,3] <> [4,5,6] == [1,2,3,4,5,6]
instance Monoid [a] where
  zero :: [a]
  zero = []
  (<>) :: [a] -> [a] -> [a]
  [] <> ys = ys
  (x:xs) <> ys = x : (xs <> ys)

------ MONOID USAGE

-- EXERCISE: Adding a value multiple times
--
-- EXAMPLES:
-- repeatMonoid (Succ (Succ (Succ Naught))) (Succ (Succ Naught)) == (Succ (Succ (Succ (Succ (Succ (Succ Naught)))))) (6 as a Nat)
-- repeatMonoid 3 [1,2,3] == [1,2,3,1,2,3,1,2,3]
repeatMonoid :: Monoid a => Nat -> a -> a
repeatMonoid Naught _ = zero
repeatMonoid (Succ n) x = x <> repeatMonoid n x

-- EXERCISE: Concatenate a list using a monoid
--
-- EXAMPLES:
-- monoidConcat [[1,2,3],[4,5,6],[7,8,9]] == [1,2,3,4,5,6,7,8,9]
-- monoidConcat [(1 :: Nat),2,3] == [<6 as a nat>]
monoidConcat :: Monoid a => [a] -> a
monoidConcat = foldr (<>) zero

-- EXERCISE: One Fun to rule them all, One Fun to find them, One Fun to bring them all and in the darkness bind them
--
-- EXAMPLES:
-- foldMap (fromInteger :: Integer -> Nat) [1,2,3] == <6 as a Nat>
-- foldMap (`repeatMonoid` [1,2]) [1,2,3] == [1,2 1,2,1,2, 1,2,1,2,1,2]
foldMap :: (Monoid b) => (a -> b) -> [a] -> b
foldMap f = monoidConcat . map f

------ ENDO

-- Endo means "from one thing to itself"
-- We use this datatype as a wrapper,
-- so we can easily create a Monoid instance for this type.
-- Think about the types!
newtype Endo a = Endo (a -> a)

getEndo :: Endo a -> a -> a
getEndo (Endo f) = f

-- EXERCISE: Endofunctions are a monoid
--
-- getEndo (Endo (+1) <> Endo (+5)) 10 == 16
-- getEndo (foldMap Endo [(+1), (*10), (`div` 2)]) 32 == 165
instance Monoid (Endo a) where
  zero :: Endo a
  zero = Endo id
  (<>) :: Endo a -> Endo a -> Endo a
  Endo f <> Endo g = Endo $ f . g

------ BITVECTOR INSTANCES

data Bit = Zero | One
  deriving (Eq, Ord, Show)

-- your favourite
data BitVector
  = End
  | BitVector :. Bit
  deriving Show

infixl 6 :.

-- This will be useful
canonicalise :: BitVector -> BitVector
canonicalise End = End
canonicalise (bv :. Zero) = case canonicalise bv of
  End -> End
  bv' -> bv' :. Zero
canonicalise (bv :. One) = canonicalise bv :. One


-- N.B.!!!:
-- We will want to canonicalise all BitVectors in both Eq and Ord before doing comparisons with them
-- for our laws to hold for both our instances.

on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on oper f x y = f x `oper` f y

-- EXERCISE: Equality on BitVectors
--
-- EXAMPLES:
-- End == End :. Zero == True
-- End :. One :. Zero == End :. One == False
instance Eq BitVector where
  (==) :: BitVector -> BitVector -> Bool
  (==) = go `on` canonicalise
    where
      go :: BitVector -> BitVector -> Bool
      go End End = True
      go (bv1 :. b1) (bv2 :. b2) = b1 == b2 && bv1 == bv2
      go _ _ = False

-- Same as above - a convenient way to write number literals instead of BitVectors
-- Hacky but convenient!
-- define only @fromInteger@
instance Num BitVector where
  fromInteger :: Integer -> BitVector
  fromInteger 0 = End
  fromInteger n = fromInteger (n `div` 2) :. if n `rem` 2 == 0 then Zero else One
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

-- EXERCISE: Adding Bitvectors
-- use bitvector addition for this!
--
-- EXAMPLES:
-- End <> End :. One -- End :. One
-- End :. Zero <> End -- End :. Zero
-- End :. Zero <> End :. One -- End :. One
-- End :. One <> End :. Zero -- End :. One
-- End :. One <> End :. One :. One -- End :. One :. Zero :. Zero
instance Monoid BitVector where
  zero :: BitVector
  zero = End
  (<>) :: BitVector -> BitVector -> BitVector
  End <> bv2 = bv2
  bv1 <> End = bv1
  (bv1 :. Zero) <> (bv2 :. Zero) = (bv1 <> bv2) :. Zero
  (bv1 :. One) <> (bv2 :. One) = succBitVector (bv1 <> bv2) :. Zero
                                 -- ^ carry the one
  (bv1 :. _) <> (bv2 :. _) = (bv1 <> bv2) :. One
  -- ^ exactly one of the bits is a One, because of our upper matches

succBitVector :: BitVector -> BitVector
succBitVector End = End :. One
succBitVector (bv :. Zero) = bv :. One
succBitVector (bv :. One) = succBitVector bv :. Zero

-- Order BitVectors as the numbers they represent
-- (in other words
-- bv1 < bv2 <=> (bitVectorToInteger bv1) < (bitVectorToInteger bv2)
-- but don't use bitVectorToInteger :P)

-- This is a bit tricky
-- Canonicalise them first!
instance Ord BitVector where
  compare :: BitVector -> BitVector -> Ordering
  compare = go `on` canonicalise
    where
      go :: BitVector -> BitVector -> Ordering
      go End End = EQ
      -- ^ if they both end at the same time, they are equal
      go End _ = LT
      -- ^ the first one runs out first, so it's smaller
      go _ End = GT
      -- ^ the second one runs out first, so the first one is greater
      go (bv1 :. bit1) (bv2 :. bit2) = case go bv1 bv2 of
      -- ^ we still have bits for both vectors
      -- we need to look at the result of the comparison of the tails
          EQ -> compare bit1 bit2
          -- ^ if the tails are equal, then the only determining factor
          -- are the current bits
          x -> x
          -- ^ if the tails actually aren't equal, then the current bits
          -- don't matter, because they are less significant
          -- and we just need to keep the order from the tails

-- EXERCISE: Booleans, but a monoid under (&&)
--
-- EXAMPLES:
-- All False <> All True == All False
-- foldMap All [True, True, True] == All True
-- foldMap All [True, True, False] == All False
newtype All = All Bool
  deriving Show

getAll :: All -> Bool
getAll (All x) = x

instance Monoid All where
  zero :: All
  zero = All True
  (<>) :: All -> All -> All
  All x <> All y = All $ x && y

-- EXERCISE: all, using All
-- Use foldMap and All to define all
all :: (a -> Bool) -> [a] -> Bool
all f = getAll . foldMap (All . f)

-- EXERCISE: Booleans, but a monoid under (||)
--
-- EXAMPLES:
-- Any False <> Any True == Any True
-- foldMap Any [True, False, False] == Any True
-- foldMap Any [False, False, False] == Any False
newtype Any = Any Bool
  deriving Show

getAny :: Any -> Bool
getAny (Any x) = x

instance Monoid Any where
  zero :: Any
  zero = Any False
  (<>) :: Any -> Any -> Any
  Any x <> Any y = Any $ x || y

-- EXERCISE: any, using Any
-- Use foldMap and Any to define any
any :: (a -> Bool) -> [a] -> Bool
any f = getAny . foldMap (Any . f)

-- EXERCISE: Merge monoid
-- This is a "party trick" monoid, which we can use to implement merge sort.
-- Our idea is that we will hold lists, but instead of the usual
-- concatenation monoid that we have for lists, we will use the
-- "merge" part of merge sort to implement our Monoid instance.
newtype Merge a = Merge [a]
  deriving Show

getMerge :: Merge a -> [a]
getMerge (Merge xs) = xs

-- Assume that the lists inside Merge are sorted!
instance Ord a => Monoid (Merge a) where
  zero :: Merge a
  zero = Merge []
  (<>) :: Merge a -> Merge a -> Merge a
  Merge l1 <> Merge l2 = Merge $ merge l1 l2
    where
      merge :: Ord a => [a] -> [a] -> [a]
      merge [] ys = ys
      merge xs [] = xs
      merge (x:xs) (y:ys)
        | x <= y = x:merge xs (y:ys)
        | otherwise = y:merge (x:xs) ys

-- EXERCISE: Merge sort, using Merge
-- Implement merge sort by using the Merge monoid and foldMap
-- NOTE: As pointed out, this isn't really merge sort, because of how
-- lists are constructed (you always end up merging "to the right",
-- instead of splitting down the middle)
mergeSort :: Ord a => [a] -> [a]
mergeSort = getMerge . foldMap (Merge . singleton)
  where
    singleton x = [x]
