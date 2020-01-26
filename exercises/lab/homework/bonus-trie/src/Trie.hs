{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE NamedFieldPuns #-}
-- ^ allows us to write shorter record matches:
-- instead of writing
-- ```
-- toAssocList Trie {val = val, children = children} ...
-- ```
--
-- we can just write
--
-- ```
-- toAssocList Trie {val, children} = ...
-- ```
--
-- with the same effect

module Trie where

data Trie a = Node
  { val :: Maybe a
  , children :: [(Char, Trie a)]
  }
  deriving (Show, Eq)

instance Functor Trie where
  fmap :: (a -> b) -> Trie a -> Trie b
  fmap = undefined

instance Foldable Trie where
  foldMap :: Monoid b => (a -> b) -> Trie a -> b
  foldMap = undefined

modify :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
modify = undefined

insert :: String -> a -> Trie a -> Trie a
insert = undefined

lookupTrie :: String -> Trie a -> Maybe a
lookupTrie = undefined

first :: (a -> c) -> (a, b) -> (c, b)
first f (x, y) = (f x, y)

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just x) = [x]

toAssocList :: Trie a -> [(String, a)]
toAssocList = undefined

fromAssocList :: [(String, a)] -> Trie a
fromAssocList = undefined
