{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- TODO: remind about homework; tell people to use HOF
-- TODO: talk about projects! give deadline for choosing


-- TODO: tell about [] vs our List (constructors, show example)
-- TODO: DEFINITELY say that matches are looked at top to bottom

-- TODO: show let where case lambdas (with reverse?)

import Prelude hiding (const, id, flip, (.), ($))

--- Functiony stuff ??
-- TODO: talk about currying...
-- TODO: say about infix functions + sections???
-- TODO: ask about (a -> a), (a -> b) inhabitants
--
-- TODO: show holes? (with e.g. (.))
(.) :: (b -> c) -> (a -> b) -> a -> c
(.) = undefined

-- taken from the standard library
infixr 9 .

-- TODO: talk about bitvectors

-- EXERCISE: Identity
-- EXAMPLES:
-- id 5 -- 5
id :: a -> a
id = undefined

-- EXERCISE: Const
-- This is useful when you want to "replace" all values with a given one.
-- EXAMPLES:
-- map (const 10) [1,2,3] -- [10,10,10]
const :: a -> b -> a
const = undefined

-- EXERCISE: Application
--
-- f $ x applies f to x
--
-- This is useful when chaining a lot of functions one after another
-- to save on writing a lot of brackets.
-- Instead of
-- not (True && False)
-- we can write
-- not $ True && False
--
-- This works because the ($) operator associates to the right and also has a *very low* precedence
--
-- EXAMPLES:
-- (*10) $ (+5) $ 10 -- 150
($) :: (a -> b) -> a -> b
($) = undefined

-- taken from the standard library
infixr 0 $

-- EXERCISE: Composition
-- Not really new, same as (.), but a different name.
-- The arrows point in the "direction in which we are processing"
-- right-to-left
-- EXAMPLES:
-- ((*10) <<< (+5)) 10 -- 150
-- (*10) <<< (+10) $ 10 -- 200
(<<<) :: (b -> c) -> (a -> b) -> a -> c
(<<<) = undefined

infixr 1 <<<

-- EXERCISE: Diagrammatic composition
-- Same as above, but left-to-right
-- EXAMPLES:
-- ((*10) >>> (+5)) 10 -- 105
-- (*10) >>> (+10) $ 10 -- 110
(>>>) :: (a -> b) -> (b -> c) -> a -> c
(>>>) = undefined

infixr 1 >>>

-- EXERCISE: Argument flipping
-- Flip the arguments of a function
-- EXAMPLES:
-- flip (-) 3 5 -- 2
flip :: (a -> b -> c) -> b -> a -> c
flip = undefined

-- EXERCISE: Apply a binary function after doing some transformation first
-- This is used infix very often.
-- EXAMPLES:
-- (on (+) succ) 0 1 -- 3 -- btw we can omit the brackets here
-- ((&&) `on` even) 2 4 -- True
-- ((||) `on` odd) 2 4 -- False
-- ((<) `on` fst) (1, 10000) (2, 0) -- True
-- ((<) `on` snd) (1, 10000) (2, 0) -- False
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on = undefined

-- taken from the standard library (Data.Function)
infixl 0 `on`

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
-- isEnd End -- True
-- isEnd (End :. One) -- False
isEnd :: BitVector -> Bool
isEnd = undefined

-- EXERCISE: Canonicalise
-- A BitVector is said to be "canonical" if it has no leading zeroes.
-- Write a function to convert a BitVector to it's canonical form.
-- EXAMPLES:
-- canonicalise End -- End
-- canonicalise (End :. One) :. Zero -- End :. One :. Zero
-- canonicalise (End :. Zero :. Zero :. One :. Zero) -- End :. One :. Zero
canonicalise :: BitVector -> BitVector
canonicalise = undefined
-- HINT:
-- Think about the recursive case on Zero - you need to do something depending on its result.

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

--- TODO: Maybe?
--- TODO: Tree?
