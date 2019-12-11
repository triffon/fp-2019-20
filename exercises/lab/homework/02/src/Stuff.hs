module Stuff
  ( group
  , sortBy
  , groupBy
  , sortOn
  , groupOn
  , classifyOn
  , (&&&)
  , on
  ) where

group :: Eq a => [a] -> [[a]]
group = undefined

insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
insertBy = undefined

sortBy :: (a -> a -> Ordering) -> [a] -> [a]
sortBy = undefined

groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy = undefined

on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on = undefined

sortOn :: Ord b => (a -> b) -> [a] -> [a]
sortOn = undefined

groupOn :: Eq b => (a -> b) -> [a] -> [[a]]
groupOn = undefined

(&&&) :: (a -> b) -> (a -> c) -> a -> (b, c)
(&&&) = undefined

-- Bonus: use Eq b instead
classifyOn :: Ord b => (a -> b) -> [a] -> [[a]]
classifyOn = undefined
