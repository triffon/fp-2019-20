{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

-- We will now be studying Haskell.
-- The most distinct/important features of Haskell are in my opinion (in this order):
-- * ADTs + types
-- * aggressive polymorphism - a lot more stuff is more polymorphic than you would expect
--   this is both a great boon, but can also be a burden if overused
-- * laziness
--
-- You can check out resources in the main README.md
--
-- Some things to note:
-- * There is no standard IDE. We will be using ghci - a repl for Haskell, to run our programs
--   I will be using vim to write Haskell.
-- * Don't use tabs! ghc will complain about tabs and for good reason -
--   Haskell is indentation sensitive and it is easy to mess up with using tabs.
--   Find out how to make your editor output 2 spaces instead of a tab

-- Let's talk about ghci
-- The most important things you can do in it are:
-- * evaluate expressions
-- * :t(ype) x - this will give you the type of x
-- * :r(eload) - reload the current file
-- * :i(nfo) x - this will give you "more info" about x (useful later)
-- * :l(oad) "filename" - load a filename

-- Haskell has types. It also has no implicit casting.
-- Unlike scheme where you can do
-- (define (omega x) (x x))
-- and it will load just fine, Haskell will reject the above expression, because x applied to x does not have a type.
--
-- Some standard types:
-- * Int - integers represented as binary numbers
-- * Integer - arbitrary sized integers
-- * Bool - we can use it with an if b then t else e statement.
-- * Char
-- * String - note that this is just a list of Chars!!!
-- * (a,b) - 2-tuples. We can access their elements via fst/snd, and construct them via the function (,)
-- * [a] - lists. We can access their head with head and their tail with tail. We can construct them with [] and (:)
--
-- Some stuff I can't categorise that we will encounter:
-- * undefined - a value with **ANY** type.
--   If you try to evaluate it, it immediately throws an exception.
--   I'm using this to leave holes for you to fill.
-- * error - Same as undefined, but allows you to put in a string which to display.
--   You will be using this at some points either as an assert or as a filler value until we learn better.
--
-- In general ALWAYS AVOID THESE! (unless you are doing assertions)
-- We HATE exceptions over in Haskell land.

-- Functions in Haskell are called like in your favourite shell (sh/bash/zsh/etc)
-- f arg1 arg2 arg3 arg4 ...
-- Brackets are used for priority!
-- So
-- f arg1 arg2 arg3
-- means apply f to arg1 arg2 and arg3
-- but
-- f (arg1 arg2) arg3
-- means apply f to (arg1 applied to arg2) and arg3

-- Haskell is a lazy language, meaning that with this definition for or:
or' :: Bool -> Bool -> Bool
or' True _ = True
or' _ True = True
or' _ _ = False
-- the invocation
-- or' True undefined
-- will evaluate to True just fine, because we aren't looking at the second argument
-- (we don't need to look at it to know that we will be returning True, because of the first clause)
-- Note how this isn't a "special form" like in scheme, but rather just a function!
-- priority on fn application; infix!
-- brackets for priority


-- The two main "things" in Haskell are
-- * Declarations - datatypes - defining new data
-- * Definitions - functions - taking apart the data and doing some operations on it

-- The general syntax for a datatype declaration looks something like this:
-- data <TypeName> = <ConstructorName0> <ArgType0> <ArgType1>... | <ConstructorName1> <ArgType0>... ...| <ConstructorNameN> ...
-- This defines a new type <TypeName>
-- which has "constructors" ConstructorName0 ... ConstructorNameN
-- each of them taking arguments of types ArgType0 ... ArgTypeN (depending on what the constructor has as arguments)
-- Forget about what is called a "constructor" in OOP languages! It has nothing to do with this!
-- You can think of constructors as "string tags" attached to some data, so that we know later when looking at the data
-- which constructor was used (depending on the string tag)

-- An example datatype. We could express this using an "enum" in other languages.
-- The "deriving Show" part tells Haskell - "Please generate a way to print this value"
-- This is useful when debugging at the repl.
data Language
  = C
  | Java
  | Haskell
  | Rails
  | Agda
  deriving Show

-- Here we have a definition. We are defining a new constant with a name
-- language0
-- which has type Language.
-- That's what x :: y means in general - "x is of type y"
-- On the second line we have the body of our definition.
-- Since it's a constant we simply state the value of the constant.
-- Since Haskell is a constructor for Language, the types match up, and this definition is fine.
language0 :: Language
language0 = Haskell

-- Another definition - a function this time.
-- The types of functions are
-- t0 -> t1 -> ... -> tn
-- the arrow separated stuff are arguments, and the thing to the right of the last arrow is the result type.

-- In this case we get one argument, of type Language.
-- We want a function to decide which languages I like.
-- Since we have an argument of type Language, we know that the only values are given by its constructors,
-- and we can manually define the values of our function for each constructor.

-- This reflects to "pattern matching" in Haskell.
-- If x is of type t
-- then we can write out "pattern matches" for each of its constructors.
-- If we define the value of the function for each constructor, then we have certainly defined the function
-- for all values of type t.
--
-- The matches are read from top to bottom - if you've gotten to the second match
-- then you certainly know that the given input language isn't Haskell.
--
-- The _ means "match everything, and don't bind a name to it".
-- We could instead write out all the other cases, but we will return False in all of them,
-- so it's annoying to do so, and we really don't care what the argument is,
-- if it's not Agda or Haskell.
goodLanguage :: Language -> Bool
goodLanguage Haskell = True
goodLanguage Agda = True
goodLanguage _ = False
-- Also note that (thanks to the pragma I've put at the top of the file)
-- if we skip out on some cases the compiler will warn us!
-- This removes our ability to forget if we put in the effort to think of proper types.

-- Another datatype, that simply holds two Ints, as an illustration of a constructor with values in it.
data CoupleOfInts = Pesho Int Int
  deriving Show

-- Let's sum the two Ints in our CoupleOfInts

-- Same principle - we can "dissasemble" the datatype CoupleOfInts by matching on the constructor.
-- Since the constructor Pesho has two ints in its first and second place
-- by writing (Pesho x y) we mean
-- "whatever is in the first place is now named x, and whatever is in the second place is now named y"
-- (in other words we bind the values in Pesho to names)
-- Note the brackets! They are necessary because otherwise
-- we would not be able to parse a pattern match with more arguments/constructors
sumCouple :: CoupleOfInts -> Int
sumCouple (Pesho x y) = x + y

-- A type with NO constructors! This is allowed. It is actually useful too.
-- Imagine having a server - you want it to run forever and never return a value
-- So if we say
-- server :: Zero
-- We really mean that "server is something that will never return a value"
data Zero

-- The datatype Bool is actually also defined as
-- data Bool = False | True
-- in the standard library.

-- Until now we've used "natural numbers" by using 0 and 1+ in scheme.
-- We can actually put into code our idea of a natural number!:

-- What does it mean to be a "Nat"ural number?
data Nat
  = Zero -- It's either Zero
  | Succ Nat -- Or it's the "Succ"essor of another "Nat"ural number
  deriving Show

-- NOTE! that we only *mean* that these are natural numbers.
-- Until we use them in functions they don't really have any computation associated with them.
-- We couldve just as well had this declaration:
-- data Chicken
--  = Dog
--  | Cat Chicken
-- And it definitely wouldn't *look* like natural numbers to us (although it would have the same structure!).
-- The names are the meanings we want to remind ourselves of! (as in all programming actually)

-- Let's get the "previous" of a natural number, i.e. -1.

-- Again we will pattern match
-- Zero has no predecessor, so we just return Zero itself.
predNat :: Nat -> Nat
predNat Zero = Zero
predNat (Succ n) = n

-- Converting integers to and from natural numbers.
integerToNat :: Integer -> Nat
integerToNat 0 = Zero
integerToNat n = Succ (integerToNat (n - 1))

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ n) = 1 + natToInteger n

-- Another type declaration - this time with a "type variable"?
-- What does this mean? You can think of template arguments in C++,
-- e.g. the T part in vector<T>
-- or similarly generics in java
--
-- We want to define lists that will hold "a" values in them.
data List a
  = Nil -- A list is either empty - it holds nothing
  | Cons a (List a) -- or it holds an "a" and it also holds another List a
  deriving Show

-- Here we've specialised the List to hold Integers, and we can now sum the numbers in it.
sumList :: List Integer -> Integer
sumList Nil = 0
sumList (Cons x xs) = x + sumList xs

-- EXERCISE: Implication
implies :: Bool -> Bool -> Bool
implies True False = False
implies _ _ = True

-- EXERCISE: And
-- We put a ' at the end, because there is already a function
-- in the standard library named "and"
-- 's are a completely ok part to put (at the end) of an identifier in Haskell.
-- We will usually use x' to mean "x but slightly different"
and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _ = False

-- EXERCISE: If
-- EXAMPLES:
-- myIf True 5 3 -- 5
-- myIf False 5 3 -- 3
myIf :: Bool -> a -> a -> a
myIf True x _ = x
myIf False _ y = y

-- EXERCISE: Plus
-- As usual.
plus :: Nat -> Nat -> Nat
plus Zero m = m
plus (Succ n) m = Succ (plus n m)

-- EXERCISE: Mult
-- You know the drill
mult :: Nat -> Nat -> Nat
mult Zero _ = Zero
mult (Succ n) m = plus m (mult n m)

-- EXERCISE: Apppend
-- yup
append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

-- EXERCISE: Reverse
-- Do the naive version - we'll talk about local definitions later.
-- Or write an additional top-level helper - whatever.
reverse' :: List a -> List a
reverse' xs = reverseHelper xs Nil

reverseHelper :: List a -> List a -> List a
reverseHelper Nil acc = acc
reverseHelper (Cons x xs) acc = reverseHelper xs (Cons x acc)

-- EXERCISE: Maximum (use max)
-- You can use
-- minBound :: Int
-- This value gives you "the smallest Int" on your machine.
-- for the empty list case.
-- That's sensible, because minBound :: Int is a "zero" for the operation max,
-- the same way 0 is a "zero" for the operation +
maximum' :: List Int -> Int
maximum' Nil = minBound :: Int
maximum' (Cons x xs) = max x (maximum' xs)
