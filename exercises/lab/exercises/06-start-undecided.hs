{-# OPTIONS_GHC -fwarn-incomplete-patterns #-} -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}      -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}  -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}      -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- TODO: everyone is using inexact values for hw00, why?
-- TODO: ping about homework 01, maybe show it? start it early!
-- TODO: motivate to PR as soon as possible so we I can comment earlier
-- TODO: ask people to NOT merge themselves

-- TODO: talk about haskell philosophy (TYPESSSSSSSSSSSSSSSS, datatypes, laziness)
-- TODO: tell people about resources
-- TODO: say about NO FUKEN TABS IN MY HASKELL
-- TODO: say about editor
--
-- TODO: show ghci
-- it's a repl, we can evaluate
-- :t(ype)
-- :i(nfo)
-- :l(oad)
-- :r(eload)
-- TODO: show types (NO IMPLICIT CASTING!!!)
-- Int, Integer, Bool, Char, String, (a,b) (fst/snd), [a] (head/tail), etc
-- undefined -- will use to fill stuff in sometimes
-- error -- use for now
-- TODO: show laziness? (vs scheme maybe?)
-- TODO: type variables
-- a -> a
-- a -> b
-- TODO: show syntax (shell syntax!)
-- priority on fn application; infix!
-- brackets for priority
--
-- TODO: declarations (datatypes - DATA) vs definitions (functions - OPERATIONS)
-- pattern matching? say about warn incomplete/unused -- case?
-- show holes? (tuple swap example is good)
-- wildcards
-- show examples? (programming languages?)
-- show bool
-- show pattern matching on bool for not and or?
-- maybe show how pattern matching relates to laziness

-- EXERCISE: Implication
implies :: Bool -> Bool -> Bool
implies = undefined

-- EXERCISE: If
myIf :: Bool -> a -> a -> a
myIf = undefined

-- EXERCISE: Add numbers

-- write nats and lists
-- nats + lists again? (deriving show!)
-- show pred on nats
-- show from,toInteger for nats?
-- show summing for lists?
--
-- EXERCISE: Plus
-- EXERCISE: Mult
-- EXERCISE: Apppend
-- EXERCISE: Reverse
-- EXERCISE: Maximum (use max?)
-- EXERCISE: Sort?

-- bitvectors? for exercise
-- | Let's have bits
-- This is *the same* as Bools - but we will use them in a different context.
-- The B prefix is because we can't have constructors with duplicate names.
data Bit = BZero | BOne
  deriving Show

-- | Above (with Nat) we had "unary" natural numbers - they were encoded in a 1-ary counting system.
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
-- so End :. BOne :. BZero
-- actually means
-- (End :. BOne) :. BZero
-- as opposed to
-- End :. (BOne :. BZero)
-- (which is invalid)

-- EXAMPLES of BitVectors:
-- Number: 0
-- Binary: 0
-- BitVector: End
--
-- Note that the representation isn't unique, so
-- End :. BZero :. BZero :. BZero
-- is also a valid represntation of 0.
--
-- Number: 5
-- Binary: 101
-- BitVector: End :. BOne :. BZero :. BOne
--
-- Number: 1023
-- Binary: 1111111111
-- BitVector: End :. BOne :. BOne :. BOne :. BOne :. BOne :. BOne :. BOne :. BOne :. BOne :. BOne

-- Don't forget that
-- End :. BOne :. BZero :. BOne
-- is actually
-- ((End :. BOne) :. BZero) :. BOne
-- So when you're doing recursion on a BitVector, you have the most "outer" Bit
-- ((End :. BOne) :. BZero) :. BOne
--                          -- ^ this one
-- EXERCISE: +1
-- Add one to a BitVector.
-- EXAMPLES:
-- succBitVector End -- End :. BOne
-- succBitVector (End :. BZero) -- End :. BOne
-- succBitVector (End :. BOne :. BOne :. BOne) -- End :. BOne :. BZero :. BZero :. BZero
succBitVector :: BitVector -> BitVector
succBitVector = undefined

-- EXERCISE: Detect if a bitvector is zero
-- This is actually helpful for the next task
-- EXAMPLES:
-- isEnd End -- True
-- isEnd (End :. BOne) -- False
isEnd :: BitVector -> Bool
isEnd = undefined

-- EXERCISE: Canonicalise
-- A BitVector is said to be "canonical" if it has no leading zeroes.
-- Write a function to convert a BitVector to it's canonical form.
-- EXAMPLES:
-- canonicalise End -- End
-- canonicalise (End :. BOne) :. BZero -- End :. BOne :. BZero
-- canonicalise (End :. BZero :. BZero :. BOne :. BZero) -- End :. BOne :. BZero
canonicalise :: BitVector -> BitVector
canonicalise = undefined
-- HINT:
-- Think about the recursive case on BZero - you need to do something depending on its result.

-- EXERCISE: Convert a number to a BitVector
-- Ideally convert numbers to canonical bitvectors.
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69 -- (End :. BOne :. BZero :. BZero :. BZero :. BOne :. BZero) :. BOne
-- integerToBitVector 5 -- (End :. BOne :. BZero) :. BOne
-- integerToBitVector 7 -- (End :. BOne :. BOne) :. BOne
integerToBitVector :: Integer -> BitVector
integerToBitVector = undefined

-- EXERCISE: Convert a BitVector to a number
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69 -- ((((((End :. BOne) :. BZero) :. BZero) :. BZero) :. BOne) :. BZero) :. BOne
-- integerToBitVector 16 -- ((((End :. BOne) :. BZero) :. BZero) :. BZero) :. BZero
bitVectorToInteger :: BitVector -> Integer
bitVectorToInteger = undefined
-- HINT: It would be easier to first canonicalise the bitvectors!

-- EXERCISE: BitVector addition
-- You're not allowed to use the conversion functions!
-- You will need to do recursion on both the BitVectors when there are BOnes here
-- to detect when overflow happens!
-- EXAMPLES:
-- addBitVector End (End :. BOne) -- End :. BOne
-- addBitVector (End :. BZero) End -- End :. BZero
-- addBitVector (End :. BZero) (End :. BOne) -- End :. BOne
-- addBitVector (End :. BOne) (End :. BZero) -- End :. BOne
-- addBitVector (End :. BOne :. BZero) (End :. BOne :. BZero :. BZero) -- End :. BOne :. BOne :. BZero
addBitVector :: BitVector -> BitVector -> BitVector
addBitVector = undefined
