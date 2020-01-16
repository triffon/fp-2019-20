{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE LambdaCase #-}
-- ^ allows us to write
--
-- \case
--   Nothing -> ...
--   Just y -> ...
--
-- instead of
--
-- \x -> case x of
--   Nothing -> ...
--   Just y -> ...

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

module Parser
  ( Parser, parse
  , nom
  , result, empty, (<|>)
  , many, some
  ) where

import Data.Maybe (fromMaybe)
import qualified Control.Applicative as A

------------------------------------------------------------
-- The parser type
------------------------------------------------------------
newtype Parser a = Parser {runParser :: String -> Maybe (String, a)}
-- in essence this is some form of "composition" of these:
-- of these three:
-- * String -> _
-- * Maybe -> _
-- * (String, _)
-- __NOTE__ that this works, but only if you adapt your intuition for "composition",
-- as just "lifting" these things with their "default" instances breaks down at Applicative

-- Run a parser ignoring the leftover string.
parse :: Parser a -> String -> Maybe a
parse px input = fmap snd $ runParser px input
------------------------------------------------------------
-- Base parsers
------------------------------------------------------------

-- | A parser that consumes one character from the input, if possible.
nom :: Parser Char
nom = Parser $ \case
  [] -> Nothing
  c:cs -> Just (cs, c)

-- | A parser that only succeeds if you've consumed all there is to consume,
-- returning a boring result.
endOfInput :: Parser ()
endOfInput = Parser $ \case
    [] -> Just ("", ())
    _  -> Nothing

------------------------------------------------------------
-- Some specialised aliases for polymorphic functions,
-- to not overload people with information
------------------------------------------------------------
-- | Consumes no input, always succeeds with a result the given argument.
result :: a -> Parser a
result = pure

-- | Attempts the left parser, if it fails, it returns the result of the right parser.
(<|>) :: Parser a -> Parser a -> Parser a
(<|>) = (A.<|>)

-- | A parser that always fails.
empty :: Parser a
empty = A.empty

-- Applies the given parser 0 or more times.
many :: Parser a -> Parser [a]
many = A.many

-- Applies the given parser 1 or more times.
some :: Parser a -> Parser [a]
some = A.some

------------------------------------------------------------
-- Instances
------------------------------------------------------------
instance Functor Parser where
  fmap :: (a -> b) -> Parser a -> Parser b
  fmap f (Parser px) =
    Parser $ \input ->
      case px input of
        Nothing -> Nothing
        Just (res, x) -> Just (res, f x)
  -- Alternative "compositional" definition (better, but less noob-friendly):
  -- fmap f = Parser . fmap (fmap (fmap f)) . runParser
  -- ^ three fmaps - going from the outermost one to the innermost one:
  -- the first one is  for String -> _
  -- the next one is for   Maybe _
  -- the next one is for   (String, _)


instance Applicative Parser where
  pure :: a -> Parser a
  pure x = Parser $ \input -> Just (input, x)
  -- ^ we don't consume any input, and simply return the value x
  -- alternative "compositional" definition (better, but less noob-friendly):
  -- pure = Parser . pure . pure . pure
  -- ^ same as for the fmap

  (<*>) :: Parser (a -> b) -> Parser a -> Parser b
  Parser pf <*> Parser px =
    Parser $ \input -> case pf input of
      Nothing -> Nothing
      Just (res, f) -> case px res of
        Nothing -> Nothing
        Just (res', x) -> Just (res', f x)
  -- alternative implementation (better, but less noob-friendly):
  -- (<*>) :: Parser (a -> b) -> Parser a -> Parser b
  -- Parser pf <*> Parser px = Parser $ \input -> do -- using Maybe as a Monad here
  --   (resString, resf) <- pf input
  --   (finalString, x) <- px resString
  --   pure $ (finalString, resf x)

  -- here's where "lifting" of instances breaks down:
  -- we might be tempted to do as above (I was, and did):
  -- liftA2 :: (a -> b -> c) -> Parser a -> Parser b -> Parser c
  -- liftA2 f (Parser px) (Parser py) = Parser $ liftA2 (liftA2 (liftA2 f)) px py
  -- (it's actually easier to define liftA2 instead of (<*>),
  -- and you only need one of (<*>) and liftA2)
  -- but this is __not__ what we want:
  -- We don't want both parts of the computation to use the same input string -
  -- we want the first one to consume some of the input, and then, if successful
  -- pass what's left of the string to the next parser

-- alternative is a type class that allows us to have
-- "try-then" computations, e.g. here we run one parser, and if it fails, we run another one
-- it's actually very similar to 'Monoid', but on (* -> *) instead of just *
-- there is even a way to turn one into the other
instance A.Alternative Parser where
  empty :: Parser a
  empty = Parser $ const Nothing

  (<|>) :: Parser a -> Parser a -> Parser a
  Parser px <|> Parser py = Parser $ \z -> px z A.<|> py z
  -- ^ here we use the Alternative instance for Maybe, which is exactly what you'd expect:
  -- Nothing <|> x = x
  -- Just y <|> _ = y
  -- (it is exactly what the Monoid for First is, from the homework)

instance Monad Parser where
  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  Parser px >>= f =
    Parser $ \input -> case px input of
      Nothing -> Nothing
      Just (res, x) -> case runParser (f x) res of
        Nothing -> Nothing
        Just (res', y) -> Just (res', y)
  -- alternative implementation using Monad for Maybe
  -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  -- Parser px >>= f = Parser $ \input -> do
  --   (res, x) <- px input
  --   runParser (f x) res
