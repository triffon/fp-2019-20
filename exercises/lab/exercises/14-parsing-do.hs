{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

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
-- no spaces!
-- CHEAT:
-- * null
-- * bools
-- * numbers (only integers!)
-- * strings (no escapes!)
-- * arrays
-- * objects
data Value
  = Null
  | Bool Bool
  | Number Integer
  | String String
  | Arrays [Value]
  | Object [(String, Value)]
  deriving Show

-- JSON EXAMPLES:
-- https://json.org/example.html
-- Null:
-- * null
-- Bools:
-- * true
-- * false
-- Numbers:
-- * 123
-- * 023
-- * 141
-- Strings:
-- * "lol"
-- * "nice d00d"
-- * "a#f#∞"
-- Arrays:
-- * [1]
-- * [null]
-- * [false,1,null]
-- * [[1,true],[false],null,"lol"]
-- * [{"heh":5},true]
-- Objects:
-- * {}
-- * {"nice":"dude"}
-- * {"nice":null}
-- * {"heh":true,"kek":null,{"array":[1,2,3]}}
-- * {"heh":true,"kek":null,{"array":[{"single":"thing"}]}}

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
aParser = do
  x <- nom
  if x == 'a'
  then result x
  else empty

-- TODO: do usage
-- Always parses the given character
--
-- EXAMPLES:
-- > parse (char 'l') "l"
-- Just 'l'
-- > parse (char 'l') "a"
-- Nothing
char :: Char -> Parser Char
char c = do
  x <- nom
  if x == c
  then result x
  else empty


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
aOrB = char 'a' <|> char 'b'

-- TODO: backtracking
-- Our parsers automatically "backtrack" always!
-- In other words, if a string is consumed while using one parser,
-- but it fails at the end, the next parser run will have access to the entire string:
aa :: Parser [Char]
aa = do
  x <- char 'a'
  y <- char 'a'
  result [x, y]

ab :: Parser [Char]
ab = do
  x <- char 'a'
  y <- char 'b'
  result [x, y]

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
aOrBStar = many aOrB

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
aOrBPlus = some aOrB

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
number = do
  let stringToNumber :: String -> Integer
      stringToNumber xs =
        foldl (\acc x -> 10 * acc + asciiToDigit x) 0 xs

  xs <- some $ satisfy isNumber
  result $ stringToNumber xs

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
satisfy p = do
  x <- nom
  if p x
  then result x
  else empty

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
--anbn :: Parser [Char]
--anbn = undefined
--
---- TODO: times; mention replicate, recursive function
---- Execute the given parser three times,
---- returning the result of parses as a list
---- EXAMPLES:
---- > parse (times 3 (char 'a')) "aaa"
---- Just "aaa"
---- > parse (times 3 (char 'a')) "abb"
---- Nothing
---- > parse (times 3 (char 'a')) "aa"
---- Nothing
---- > parse (times 3 (satisfy isNumber)) "123"
---- Just "123"
times :: Int -> Parser a -> Parser [a]
times 0 _ = result []
times n p = do
  x <- p
  xs <- times (n - 1) p
  result $ x:xs

-- 'ord' returns the Char as an Int
-- for ascii chars this is like getting their ascii table number
asciiToDigit :: Char -> Integer
asciiToDigit c =
  if '0' <= c && c <= '9'
  then fromIntegral $ ord c - ord '0'
  else error $ "You're calling me with a non-number Char:" ++ [c]

-- EXERCISE: String parser
-- Parse the given string, and only the given string
-- Proceed recursively!
-- EXAMPLES:
-- > parse (string "kami") "kami"
-- Just "kami"
-- > parse (string "kami") "kam"
-- Nothing
-- > parse (string "kami") "hair"
-- Nothing
-- > parse (string "kami") "kamipaper"
-- Just "kami"
string :: String -> Parser String
string str = undefined

-- EXERCISE: Null parser
-- You can use ((<$) :: a -> Parser b -> Parser a) here for conciseness, if you so desire.
-- EXAMPLES:
-- > parse nullParser "null"
-- Just Null
-- > parse nullParser "nul"
-- Nothing
-- > parse nullParser "true"
-- Nothing
nullParser :: Parser Value
nullParser = undefined

-- EXERCISE: False parser
-- EXAMPLES:
-- > parse falseParser "false"
-- Just (Bool False)
-- > parse falseParser "falsE"
-- Nothing
-- > parse falseParser "true"
-- Nothing
falseParser :: Parser Value
falseParser = undefined

-- EXERCISE: True parser
-- EXAMPLES:
-- > parse trueParser "true"
-- Just (Bool True)
-- > parse trueParser "True"
-- Nothing
-- > parse trueParser "false"
-- Nothing
trueParser :: Parser Value
trueParser = undefined

-- EXERCISE: Bool parser
-- EXAMPLES:
-- > parse boolParser "true"
-- Just (Bool True)
-- > parse boolParser "false"
-- Just (Bool False)
-- > parse boolParser "fls"
-- Nothing
-- > parse boolParser "no"
-- Nothing
boolParser :: Parser Value
boolParser = undefined

-- EXERCISE: Number parser
-- We already did this! (<$>)/fmap is useful here
-- fmap :: (a -> b) -> Parser a -> Parser b
-- EXAMPLES:
-- > parse numberParser "69"
-- Just (Number 69)
-- > parse numberParser "0420"
-- Just (Number 420)
-- > parse numberParser "a0420"
-- Nothing
-- > parse numberParser "aasdf"
-- Nothing

numberParser :: Parser Value
numberParser = undefined

-- EXERCISE: Surround a parser with another one
-- Get two parser and "surround" the second one with the first.
-- EXAMPLES:
-- > parse (surround (char '"') number) "\"123\""
-- Just 123
-- > parse (surround (char '"') number) "\"123"
-- Nothing
-- > parse (surround (char '"') number) "123\""
-- Nothing
-- > parse (surround number nullParser) "345null123"
-- Just Null
surround :: Parser around -> Parser b -> Parser b
surround surrounding p = undefined

-- EXERCISE: String parser
-- You can assume that there are no double quotes in the string "
-- EXAMPLES:
-- > parse stringParser "\"nice d00d\""
-- Just (String "nice d00d")
-- > parse stringParser "\"\""
-- Just (String "")
-- > parse stringParser "\"bleh\""
-- Just (String "bleh")
-- > parse stringParser ""
-- Nothing
-- > parse stringParser "\"bleh"
-- Nothing
-- > parse stringParser "bleh\""
-- Nothing
stringParser :: Parser Value
stringParser = undefined

-- EXERCISE: Between
-- Surround a parser with an opening and closing one
-- EXAMPLES:
-- > parse (between (char '"') (char '"') number) "\"123\""
-- Just 123
-- > parse (between (char '{') (char '}') (string "nice")) "{nice}"
-- Just "nice"
-- > parse (between (char '{') (char '}') (string "nice")) "{noice}"
-- Nothing
between :: Parser open -> Parser close -> Parser a -> Parser a
between open close inside = undefined

-- EXERCISE: Attempt to parse a value, returning a Nothing if we fail
-- You will need to use (<|>) here!
-- fmap :: (a -> b) -> Parser a -> Parser b
-- might be useful here, to wrap our result in a Just
-- EXAMPLES:
-- > parse (optional (string "lol")) "lol"
-- Just (Just "lol")
-- > parse (optional (string "lol")) "lo"
-- Just Nothing
-- > parse (optional (char ',')) ",nice"
-- Just (Just ',')
optional :: Parser a -> Parser (Maybe a)
optional p = undefined

-- EXERCISE: A parser that runs both parser, but ignores the result of the left one.
-- This is traditionally (<*), and is available for all Applicatives
-- EXAMPLES:
-- > parse (ignoreRight (char 'a') (char 'b')) "ab"
-- Just 'a'
-- > parse (ignoreRight (char 'a') (char 'b')) "a"
-- Nothing
-- > parse (ignoreRight (char 'a') (char 'b')) "ba"
-- Nothing
ignoreRight :: Parser a -> Parser b -> Parser a
ignoreRight px py = undefined

-- EXERCISE: Parse a value one or more times, separated by another parser.
-- many, optional and ignoreLeft are useful here!
-- EXAMPLES:
-- > parse (sepBy1 nom (char ',')) "a,b,c,d"
-- Just "abcd"
-- > parse (sepBy1 nom (char ',')) "a,b,c,"
-- Nothing
-- > parse (sepBy1 nom (char ',')) "a"
-- Just "a"
-- > parse (sepBy1 nom (char ',')) ""
-- Nothing
sepBy :: Parser a -> Parser sep -> Parser [a]
sepBy p sep = undefined

-- EXERCISE: Array parser
-- You can assume (you will write it in a second)
-- that there already exists (it does, down below) a global valueParser,
-- which parses any kind of json value
-- EXAMPLES:
-- > parse arrayParser "[]"
-- Just (Array [])
-- > parse arrayParser "[1,2,3]"
-- Just (Array [Number 1,Number 2,Number 3])
-- > parse arrayParser "[true,null,3]"
-- Just (Array [Bool True,Null,Number 3])
-- > parse arrayParser "[true,\"nulllol\",3]"
-- Just (Array [Bool True,String "nulllol",Number 3])
--
-- ---- EXAMPLES BELOW THIS POINT REQUIRE YOU TO HAVE IMPLEMENTED objectParser
-- > parse arrayParser "[{}]"
-- Just (Array [Object []])
-- > parse arrayParser "[{},{},{}]"
-- Just (Array [Object [],Object [],Object []])
-- > parse arrayParser "[{\"key0\":null},{\"key1\":2},{\"key2\":true}]"
-- Just (Array [Object [("key0",Null)],Object [("key1",Number 2)],Object [("key2",Bool True)]])
arrayParser :: Parser Value
arrayParser = undefined

-- EXERCISE: Parse a single entry in an object
-- EXAMPLES:
-- > parse objectElementParser "\"name\":\"val\""
-- Just ("name",String "val")
-- > parse objectElementParser "\"name\":null"
-- Just ("name",Null)
-- > parse objectElementParser "\"name\":true"
-- Just ("name",Bool True)
--
-- ---- EXAMPLES BELOW THIS POINT REQUIRE YOU TO HAVE IMPLEMENTED arrayParser
-- > parse objectElementParser "\"name\":[1,2,3]"
-- Just ("name",Array [Number 1,Number 2,Number 3])
-- > parse objectElementParser "\"name\":[1,null,3]"
-- Just ("name",Array [Number 1,Null,Number 3])
--
-- ---- EXAMPLES BELOW THIS POINT REQUIRE YOU TO HAVE IMPLEMENTED objectParser
-- > parse objectElementParser "\"name\":{}"
-- Just ("name",Object [])
-- > parse objectElementParser "\"name\":{\"nameagain\":null}"
-- Just ("name",Object [("nameagain",Null)])
objectElementParser :: Parser (String, Value)
objectElementParser = undefined

-- EXERCISE: Object parser
-- This has a "dummy" implementation right now, because of technical reasons*.
-- Delete it and write your own!
-- It is assumed all other things are implemented in the examples!
-- I've placed "prettified" versions of the strings before their corresponding example
--
-- > parse objectParser "{}"
-- Just (Object [])
--
-- -- rendered normally:
-- -- {"pesho": "krava"}
--
-- > parse objectParser "{\"pesho\":\"krava\"}"
-- Just (Object [("pesho",String "krava")])
--
-- -- rendered normally:
-- -- {"pesho": {"krava":null, "doggo":"Deogie"}}
--
-- > parse objectParser "{\"pesho\":{\"krava\":null,\"doggo\":\"Deogie\"}}"
-- Just (Object [("pesho",Object [("krava",Null),("doggo",String "Deogie")])])
--
-- -- rendered normally:
-- -- { "pesho": {"krava": null, "doggo": "Deogie"}
-- -- , "69": [420, 1337]
-- -- }
--
-- > parse objectParser "{\"pesho\":{\"krava\":null,\"doggo\":\"Deogie\"},\"69\":[420,1337]}"
-- Just (Object [("pesho",Object [("krava",Null),("doggo",String "Deogie")]),("69",Array [Number 420,Number 1337])])
objectParser :: Parser Value
objectParser = do
  char 'c'
  result $ Object []
-- * Technical reasons:
-- Because arrayParser (most likely) uses 'many' to parse objects within it,
-- and many will infinitely loop
-- if the parser you are calling it with doesn't consume any input.

valueParser :: Parser Value
valueParser
    = nullParser
  <|> boolParser
  <|> numberParser
  <|> stringParser
  <|> arrayParser
  <|> objectParser
