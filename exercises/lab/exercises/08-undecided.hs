{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- TODO: ask about additional exercises, because we're skipping two due to new years stuff
-- TODO: extend deadline?

import Prelude hiding (concat, map, filter, foldl, foldr)

----------------------------- BITVECTORS -------------------------------------
-- | Let's have bits
-- This is *the same* as Bools - but we will use them in a different context.
data Bit = Zero | One
  deriving Show

-- | Before (with Nat) we had "unary" natural numbers - they were encoded in a 1-ary counting system.
-- We can also represent natural numbers in a more familiar to you way - binary.
-- A number is then a list of bits. We will call this a BitVector.
--
data BitVector
  = End -- ^ The empty bit vector - the number 0
  | BitVector :. Bit
  -- ^ we can have OPERATORS as constructor names
  -- This constructor adds another bit to the BitVector
  -- We put the bit on the right, because that's how we write them out on paper.
  -- Otherwise we will have to remember that the vector is "flipped"
  deriving Show

infixl 6 :.
-- Not important for you right now, but
-- this says that the :. operator associates to the left
-- so End :. One :. Zero
-- actually means
-- (End :. One) :. Zero
-- as opposed to
-- End :. (One :. Zero)
-- which is not well typed,
-- because the (:.) constructor expects a BitVector on the left, not a Bit

-- EXAMPLES of BitVectors:
-- Number: 0
-- Binary: 0
-- BitVector: End
--
-- Note that the representation isn't unique, so
-- End :. Zero :. Zero :. Zero
-- is also a valid represntation of 0.
--
-- Number: 6
-- Binary: 110
-- BitVector: End :. One :. One :. Zero
--
-- Number: 5
-- Binary: 101
-- BitVector: End :. One :. Zero :. One
--
-- Number: 1023
-- Binary: 1111111111
-- BitVector: End :. One :. One :. One :. One :. One :. One :. One :. One :. One :. One

-- Don't forget that
-- End :. One :. Zero :. One
-- is actually
-- ((End :. One) :. Zero) :. One
-- So when you're doing recursion on a BitVector, you have the most "outer" Bit in your pattern match
-- ((End :. One) :. Zero) :. One
--                          -- ^ this one

-- EXERCISE: +1
-- Add one to a BitVector.
-- EXAMPLES:
-- succBitVector End -- End :. One
-- succBitVector (End :. Zero) -- End :. One
-- succBitVector (End :. One :. One :. One) -- End :. One :. Zero :. Zero :. Zero
succBitVector :: BitVector -> BitVector
succBitVector = undefined

-- EXERCISE: Detect if a bitvector is zero
-- This is actually helpful for the next task
-- EXAMPLES:
-- isZero End -- True
-- isZero (End :. Zero :. Zero) -- True
-- isZero (End :. One :. Zero) -- False
-- isZero (End :. One) -- False
isZero :: BitVector -> Bool
isZero = undefined

-- EXERCISE: Canonicalise
-- A BitVector is said to be "canonical" if it has no leading zeroes.
-- Write a function to convert a BitVector to it's canonical form.
-- EXAMPLES:
-- canonicalise End -- End
-- canonicalise (End :. One :. Zero) -- End :. One :. Zero
-- canonicalise (End :. Zero :. Zero :. One :. Zero) -- End :. One :. Zero
canonicalise :: BitVector -> BitVector
canonicalise = undefined
-- HINT:
-- Use isZero

-- EXERCISE: Convert a number to a BitVector
-- Ideally convert numbers to canonical bitvectors.
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69 -- End :. One :. Zero :. Zero :. Zero :. One :. Zero :. One
-- integerToBitVector 5 -- End :. One :. Zero :. One
-- integerToBitVector 7 -- End :. One :. One :. One
integerToBitVector :: Integer -> BitVector
integerToBitVector = undefined

-- EXERCISE: Convert a BitVector to a number
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69 -- End :. One :. Zero :. Zero :. Zero :. One :. Zero :. One
-- integerToBitVector 16 -- End :. One :. Zero :. Zero :. Zero :. Zero
bitVectorToInteger :: BitVector -> Integer
bitVectorToInteger = undefined
-- HINT: It would be easier to first canonicalise the bitvectors!

-- EXERCISE: BitVector addition
-- You're not allowed to use the conversion functions!
-- You will need to do recursion on both the BitVectors when there are Ones here
-- to detect when overflow happens!
-- EXAMPLES:
-- addBitVector End (End :. One) -- End :. One
-- addBitVector (End :. Zero) End -- End :. Zero
-- addBitVector (End :. Zero) (End :. One) -- End :. One
-- addBitVector (End :. One) (End :. Zero) -- End :. One
-- addBitVector (End :. One :. Zero) (End :. One :. Zero :. Zero) -- End :. One :. One :. Zero
addBitVector :: BitVector -> BitVector -> BitVector
addBitVector = undefined

----------------------------- Misc. list stuff -------------------------------------

map :: (a -> b) -> [a] -> [b]
map = undefined

filter :: (a -> Bool) -> [a] -> [a]
filter = undefined

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr = undefined

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl = undefined

fromTo :: Integer -> Integer -> [Integer]
fromTo = undefined

interleave :: [a] -> [a] -> [a]
interleave = undefined

megaInterleave :: [[a]] -> [a]
megaInterleave = undefined

concat :: [[a]] -> [a]
concat = undefined

insert :: Integer -> [Integer] -> [Integer]
insert = undefined

insertionSort :: [Integer] -> [Integer]
insertionSort = undefined

merge :: [Integer] -> [Integer] -> [Integer]
merge = undefined

mergeSort :: [Integer] -> [Integer]
mergeSort = undefined

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition = undefined

quickSort :: [Integer] -> [Integer]
quickSort = undefined

group :: [Integer] -> [[Integer]]
group = undefined

groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy = undefined

-- TODO: maybe not?
data ComparisonResult
  = LessThan
  | Equal
  | GreaterThan

insertBy :: (a -> a -> ComparisonResult) -> a -> [a] -> [a]
insertBy = undefined

sortBy :: (a -> a -> ComparisonResult) -> [a] -> [a]
sortBy = undefined

classify :: (a -> Integer) -> [a] -> [[a]]
classify = undefined

-- TODO: Maybe not below here?
from :: Integer -> [Integer]
from = undefined

naturals :: [Integer]
naturals = undefined

facts :: [Integer]
facts = undefined

factsFaster :: [Integer]
factsFaster = undefined

fibs :: [Integer]
fibs = undefined

fibsFaster :: [Integer]
fibsFaster = undefined

prime :: Integer -> Bool
prime = undefined

primes :: [Integer]
primes = undefined

primesFaster :: [Integer]
primesFaster = undefined

eratosthenes :: [Integer] -> [Integer]
eratosthenes = undefined
