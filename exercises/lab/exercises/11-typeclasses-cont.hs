{-# LANGUAGE InstanceSigs #-}

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Semigroup(..), Monoid(..), foldMap)

-- TODO: newtypes
-- TODO: mention InstanceSigs
-- with example

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
--
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

data Bit = Zero | One
  deriving (Eq, Ord, Show)

-- LAWS:
class Monoid a where
  zero :: a
  (<>) :: a -> a -> a
-- Monoid laws:
-- for all x y z:
-- zero is identity - zero <> x == x == x <> zero
-- (<>) is associative - (x <> y) <> z == x <> (y <> z)

infixr 6 <>

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
  (==) = undefined

-- EXERCISE: Ordering for Nats
instance Ord Nat where
  -- choose one to implement, you can delete the other one
  compare :: Nat -> Nat -> Ordering
  compare = undefined
  (<=) :: Nat -> Nat -> Bool
  (<=) = undefined

-- EXERCISE: Addition on Nats
-- EXAMPLES:
-- 0 <> 13 = 13
-- 5 <> 10 == 15
instance Monoid Nat where
  zero :: Nat
  zero = undefined
  (<>) :: Nat -> Nat -> Nat
  (<>) = undefined

-- EXERCISE: Appending lists
-- EXAMPLES:
-- [1,2,3] <> [] == [1,2,3]
-- [1,2,3] <> [4,5,6] == [1,2,3,4,5,6]
instance Monoid [a] where
  zero :: [a]
  zero = undefined
  (<>) :: [a] -> [a] -> [a]
  (<>) = undefined

------ MONOID USAGE

-- EXERCISE: Adding a value multiple times
--
-- EXAMPLES:
-- repeatMonoid (Succ (Succ (Succ Naught))) (Succ (Succ Naught)) == (Succ (Succ (Succ (Succ (Succ (Succ Naught)))))) (6 as a Nat)
-- repeatMonoid 3 [1,2,3] == [1,2,3,1,2,3,1,2,3]
repeatMonoid :: Monoid a => Nat -> a -> a
repeatMonoid = undefined

-- EXERCISE: Concatenate a list using a monoid
--
-- EXAMPLES:
-- monoidConcat [[1,2,3],[4,5,6],[7,8,9]] == [1,2,3,4,5,6,7,8,9]
-- monoidConcat [(1 :: Nat),2,3] == [<6 as a nat>]
monoidConcat :: Monoid a => [a] -> a
monoidConcat = undefined

-- EXERCISE: One Fun to rule them all, One Fun to find them, One Fun to bring them all and in the darkness bind them
--
-- EXAMPLES:
-- foldMap integerToNat [1,2,3] == <6 as a Nat>
-- foldMap (`repeatMonoid` [1,2]) [1,2,3] == [1,2 1,2,1,2, 1,2,1,2,1,2]
foldMap :: (Monoid b) => (a -> b) -> [a] -> b
foldMap = undefined

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
  zero = undefined
  (<>) :: Endo a -> Endo a -> Endo a
  (<>) = undefined

------ BITVECTOR INSTANCES
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

-- EXERCISE: Equality on BitVectors
--
-- EXAMPLES:
-- End == End :. Zero == True
-- End :. One :. Zero == End :. One == False
instance Eq BitVector where
  (==) :: BitVector -> BitVector -> Bool
  (==) = undefined

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
  zero = undefined
  (<>) :: BitVector -> BitVector -> BitVector
  (<>) = undefined

-- Order BitVectors as the numbers they represent
-- (in other words
-- bv1 < bv2 <=> (bitVectorToInteger bv1) < (bitVectorToInteger bv2)
-- but don't use bitVectorToInteger :P)

-- This is a bit tricky
-- Canonicalise them first!

-- You can run a test by uncommenting the quickcheck import up top
-- and writing `quickCheck prop_compareWorksBitVector`
-- in ghci
-- The test checks precisely the condition above, for randomly generated
-- canonical bitvectors.
instance Ord BitVector where
  -- choose one to implement, you can delete the other one
  compare :: BitVector -> BitVector -> Ordering
  compare = undefined
  (<=) :: BitVector -> BitVector -> Bool
  (<=) = undefined

-- Uncomment below here if you want tests
--instance Arbitrary Bit where
--  arbitrary = elements [Zero, One]
--
--instance Arbitrary BitVector where
--  arbitrary = (canonicalise . listToBv) <$> listOf arbitrary
--    where
--      listToBv :: [Bit] -> BitVector
--      listToBv [] = End
--      listToBv (b:bs) = listToBv bs :. b
--
--prop_compareWorksBitVector :: BitVector -> BitVector -> Bool
--prop_compareWorksBitVector bv1 bv2 =
--  compare bv1 bv2 == (compare `on` bitVectorToInteger) bv1 bv2
--  where
--    bitVectorToInteger :: BitVector -> Integer
--    bitVectorToInteger = go . canonicalise
--      where
--        go :: BitVector -> Integer
--        go End = 0
--        go (bv :. Zero) = 2 * go bv
--        go (bv :. One) = 1 + 2 * go bv


-- TODO: Any, All, Add, Mult, bitvectors, Endo?
-- foldmap with this :P
--data Merge a = Merge [a]
--
--getMerge :: Merge a -> [a]
--getMerge (Merge xs) = xs
--
--instance Ord a => Monoid (Merge a) where
--  zero = []
--  Merge x <> Merge y = Merge $ merge x y
--    where
--      merge [] ys = ys
--      merge xs [] = xs
--      merge (x:xs) (y:ys)
--        | x <= y = x : merge xs (y:ys)
--        | otherwise = y : merge (x:xs) ys
