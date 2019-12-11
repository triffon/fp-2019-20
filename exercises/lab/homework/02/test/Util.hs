module Util
  ( allEqBy
  , allEqByNonEmpty
  , allNonEmpty
  , sortEq
  , describeWithFun
  , concatNonEmpty
  , toList
  ) where

import StuffNonEmpty

import Data.List (sort)
import Data.Function (on)
import Test.Hspec

allEqBy :: (a -> a -> Bool) -> [[a]] -> Bool
allEqBy eq = all (\ys -> let y' = head ys in all (eq y') ys)

allEqByNonEmpty :: (a -> a -> Bool) -> [NonEmpty a] -> Bool
allEqByNonEmpty eq = all (\ys -> let (y':|_) = ys in allNonEmpty (eq y') ys)

allNonEmpty :: (a -> Bool) -> NonEmpty a -> Bool
allNonEmpty p (x:|xs) = p x && all p xs

sortEq :: Ord a => [a] -> [a] -> Bool
sortEq = (==) `on` sort

describeWithFun :: String -> Spec -> Spec
describeWithFun fName = describe ("for " ++ fName ++ ":")

concatNonEmpty :: [NonEmpty a] -> [a]
concatNonEmpty = concatMap toList

toList :: NonEmpty a -> [a]
toList (x:|xs) = x:xs
