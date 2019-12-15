{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Semigroup(..), Monoid(..), foldMap)

-- Uncomment this bit out if you want tests
--import Data.Function (on)
--import Test.QuickCheck
--
--
--
---- TODO: if two functions are nearly the same factor out the common bits!!
---- TODO: project deadlines
---- TODO: third homework
---- TODO: this sunday
--
--
---- TODO: talk what a typeclass is (interfaces, sets of types, predicates)
--
--
---- Num and Show are special
---- motivation for typeclasses
---- typeclasses vs abstract classes
---- reverse (parametric) vs sort (ad-hoc)
----reverse' :: [a] -> [a]
----sort :: Ord a => [a] -> [a]
--
---- show how to define a typeclass (myeq)
--class Eq a where -- == or /=
--  (==) :: a -> a -> Bool
--  x == y = not (x /= y)
--  (/=) :: a -> a -> Bool
--  x /= y = not (x == y)
--
---- TODO: mention derived instances!
--data Ordering = LT | EQ | GT
--
--instance Eq Ordering where
--  LT == LT = True
--  EQ == EQ = True
--  GT == GT = True
--  _ == _ = False
--
---- compare 5 10 == LT -- 5 less than 10
---- compare 10 10 == EQ -- 10 equal to 10
---- compare 15 10 == GT -- 15 equal to 10
--class Eq a => Ord a where -- <= or compare
--  compare :: a -> a -> Ordering
--  compare x y
--    | x <= y && y <= x = EQ
--    | x <= y = LT
--    | otherwise = GT
--  (<=) :: a -> a -> Bool
--  x <= y = case compare x y of
--            LT -> True
--            EQ -> True
--            GT -> False
---- show how to instance a typeclass
--
--
--
---- TODO: show examples here (Eq, Ord)
---- TODO: show NUM convenience on this
data Bit = Zero | One
  deriving (Eq, Ord, Show)

--instance Eq Bit where
--  (==) One Zero = False
--  (==) Zero One = False
--  (==) _ _ = True
--
--instance Ord Bit where
--  compare One Zero = GT
--  compare Zero One = LT
--  compare _ _ = EQ

-- TODO: talk about laws
-- example: EQ laws
-- reflexive (x == x)
-- sym (x == y -> y == x)
-- trans (x == y && y == z -> x == z)

-- TODO: mention this
-- LAWS:
-- (zero is identity)
-- for all x: zero <> x == x == x <> zero
-- (<> is associative)
-- for all x y z: (x <> y) <> z == x <> (y <> z)
class Monoid a where
  zero :: a
  (<>) :: a -> a -> a

infixr 6 <>

-- Use Naught instead of Zero so we can use Zero for bits
data Nat = Naught | Succ Nat
  deriving Show

-- EXERCISE: Integer -> Nat
-- partial, but convenient
-- @fromInteger@ is the convenient bit
instance Num Nat where
  fromInteger = undefined

-- EXERCISE: Equality for Nats
instance Eq Nat where

-- EXERCISE: Ordering for Nats
instance Ord Nat where

-- EXERCISE: Addition on Nats
-- EXAMPLES:
-- 0 <> 13 = 13
-- 5 <> 10 == 15
instance Monoid Nat where

-- EXERCISE: Appending lists
-- EXAMPLES:
-- [1,2,3] <> [] == [1,2,3]
-- [1,2,3] <> [4,5,6] == [1,2,3,4,5,6]
instance Monoid [a] where

------ USING

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
data Endo a = Endo (a -> a)

getEndo :: Endo a -> a -> a
getEndo (Endo f) = f

-- EXERCISE: Endofunctions are a monoid
--
-- getEndo (Endo (+1) <> Endo (+5)) 10 == 16
-- getEndo (foldMap Endo [(+1), (*10), (`div` 2)]) 32 == 165
instance Monoid (Endo a) where

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

-- EXERCISE: Equality on BitVectors
--
-- EXAMPLES:
-- End == End :. Zero == True
-- End :. One :. Zero == End :. One == False
instance Eq BitVector where

-- hacky but convenient!
-- define only @fromInteger@
instance Num BitVector where
  fromInteger = undefined

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
