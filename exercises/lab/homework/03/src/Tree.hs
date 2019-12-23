{-# LANGUAGE InstanceSigs #-}

module Tree where

import Prelude
import Data.Monoid (Sum(..), All(..), First(..))
import Data.Maybe (isJust)

data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show

instance Eq a => Eq (Tree a) where
  (==) :: Tree a -> Tree a -> Bool
  (==) = undefined

insertOrdered :: Ord a => a -> Tree a -> Tree a
insertOrdered = undefined

listToBST :: Ord a => [a] -> Tree a
listToBST = undefined

isBST :: Ord a => Tree a -> Bool
isBST = undefined

-- idea for implementing isBST - delete if you don't want it
data BotTop a = Bot | Val a | Top
  deriving (Show, Eq, Ord)

between :: Ord a => BotTop a -> BotTop a -> Tree a -> Bool
between = undefined

findBST :: Ord a => a -> Tree a -> Bool
findBST = undefined

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree = undefined

foldTree :: Monoid a => Tree a -> a
foldTree = undefined

foldMapTree :: Monoid b => (a -> b) -> Tree a -> b
foldMapTree = undefined

-- sum monoid hint
sumTree :: Num a => Tree a -> a
sumTree = undefined

-- all monoid hint
allTree :: (a -> Bool) -> Tree a -> Bool
allTree = undefined

-- [] monoid hint
treeToList :: Tree a -> [a]
treeToList = undefined

-- could use findPred
elemTree :: Eq a => a -> Tree a -> Bool
elemTree = undefined

onMaybe :: (a -> Bool) -> a -> Maybe a
onMaybe p x = if p x then Just x else Nothing

-- first monoid hint
findPred :: (a -> Bool) -> Tree a -> Maybe a
findPred = undefined

-- list monoid hint
findAll :: (a -> Bool) -> Tree a -> [a]
findAll = undefined

ifJust :: Maybe a -> (a -> Maybe b) -> Maybe b
ifJust Nothing _ = Nothing
ifJust (Just x) f = f x

-- use ifJust hint
validateTree :: (a -> Maybe b) -> Tree a -> Maybe (Tree b)
validateTree = undefined

data Direction
  = L -- go left
  | R -- go right
  deriving (Show, Eq)

-- hint: make a function : Tree a -> Tree (a, [Direction])
paths :: Tree a -> [(a, [Direction])]
paths = undefined

fetch :: [Direction] -> Tree a -> Maybe a
fetch = undefined
