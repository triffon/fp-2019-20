-- TODO: poll for examination; please submit your things asap!
-- TODO: poll for opinions
-- TODO: book room for sunday, mention sunday

import Parser
  ( Parser, nom
  , parse
  , result, empty, (<|>)
  , many, some
  )

import Data.Char (ord, isNumber)

-- TODO: explain json

-- TODO: explain Parser
-- implement stuff!
-- show nom first!
-- show result first!
-- show empty first!

-- Always parses only an 'a'
--
-- EXAMPLES:
-- > parse aParser "a"
-- Just 'a'
-- > parse aParser "b"
-- Nothing
aParser :: Parser Char
aParser = undefined

-- TODO: do usage
-- Always parses the given character
--
-- EXAMPLES:
-- > parse (char 'l') "l"
-- Just 'l'
-- > parse (char 'l') "a"
-- Nothing
char :: Char -> Parser Char
char c = undefined

-- TODO: alternative
-- Always parses either an @a@ or a @b@
--
-- EXAMPLES:
-- > parse aOrB "a"
-- Just 'a'
-- > parse aOrB "b"
-- Just 'b'
-- > parse aOrB "A"
-- Nothing
aOrB :: Parser Char
aOrB = undefined

-- TODO: backtracking
-- Our parsers automatically "backtrack" always!
-- In other words, if a string is consumed while using one parser,
-- but it fails at the end, the next parser run will have access to the entire string:
aa :: Parser [Char]
aa = undefined

ab :: Parser [Char]
ab = undefined

-- Th example itself:
-- > parse aa "aa"
-- Just "aa"
-- > parse aa "ab"
-- Nothing
-- > parse (aa <|> ab) "ab"
-- Just "ab"
-- note how in the last case, even though @aa@ successfuly consumes the first 'a'
-- and fails afterwards, @ab@ still manages to consume "ab", because the string
-- has been "rewound" to its initial state before @aa@ runs

-- TODO: zero or more
-- mention how parsers AREN'T required to consume all the input
-- Parses an @a@ or a @b@ 0 or more times
-- It __always__ returns a @Just@, because it can succeed even on 0 tries.
--
-- EXAMPLES:
-- > parse aOrBStar "ababa"
-- Just "ababa"
-- > parse aOrBStar "abbba"
-- Just "abbba"
-- > parse aOrBStar "albbbb"
-- Just "a"
-- > parse aOrBStar ""
-- Just ""
aOrBStar :: Parser [Char]
aOrBStar = undefined

-- TODO: one or more; mention nonempty
-- Parses an @a@ or a @b@ __1__ or more times
--
-- EXAMPLES:
-- > parse aOrBPlus "ababa"
-- Just "ababa"
-- > parse aOrBPlus "abbba"
-- Just "abbba"
-- > parse aOrBPlus "albbbb"
-- Just "a"
-- > parse aOrBPlus ""
-- Nothing -- difference from aOrBStar
aOrBPlus :: Parser [Char]
aOrBPlus = undefined

-- TODO: other parse results, implement satisfy, show let binding
-- Parses a whole number.
-- asciiToDigit is defined at the bottom of the file, it's not very interesting.
--
-- EXAMPLES:
-- > parse number "123"
-- Just 123
-- > parse number "1a23"
-- Just 1
-- > parse number "lol"
-- Nothing
-- > parse number ""
-- Nothing
number :: Parser Integer
number = undefined

-- Parse a character that satisfies a predicate
-- More general than 'char'
--
-- EXAMPLES:
-- > parse (satisfy isNumber) "l"
-- Nothing
-- > parse (satisfy isNumber) "1"
-- Just '1'
-- > parse (satisfy (=='a')) "a"
-- Just 'a'
-- > parse (satisfy (=='a')) "b"
-- Nothing
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = undefined

-- TODO: using the result of a parser in other parses
-- Parses a^nb^n
-- implement times
--
-- EXAMPLES:
-- > parse anbn "ab"
-- Just "ab"
-- > parse anbn "aabb"
-- Just "aabb"
-- > parse anbn "aab"
-- Nothing
anbn :: Parser [Char]
anbn = undefined

-- TODO: times; mention replicate, recursive function
-- Execute the given parser three times,
-- returning the result of parses as a list
-- EXAMPLES:
-- > parse (times 3 (char 'a')) "aaa"
-- Just "aaa"
-- > parse (times 3 (char 'a')) "abb"
-- Nothing
-- > parse (times 3 (char 'a')) "aa"
-- Nothing
-- > parse (times 3 (satisfy isNumber)) "123"
-- Just "123"
times :: Int -> Parser a -> Parser [a]
times n p = undefined

-- 'ord' returns the Char as an Int
-- for ascii chars this is like getting their ascii table number
asciiToDigit :: Char -> Integer
asciiToDigit c =
  if '0' <= c && c <= '9'
  then fromIntegral $ ord c - ord '0'
  else error $ "You're calling me with a non-number Char:" ++ [c]
