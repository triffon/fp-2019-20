{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}

module StuffNonEmptyTest
  ( stuffNonEmptySpec
  ) where

import StuffNonEmpty

import Data.Function (on)
import Test.Hspec
import Test.Hspec.QuickCheck
import Util

stuffNonEmptySpec :: Spec
stuffNonEmptySpec = do
  groupNonEmptySpec
  groupByNonEmptySpec
  groupOnNonEmptySpec
  classifyOnNonEmptySpec

groupNonEmptySpec :: Spec
groupNonEmptySpec = describe "groupNonEmpty" do
  prop "Concatting after groupNonEmptying should yield the original list"
    \(xs :: [Int]) -> concatNonEmpty (groupNonEmpty xs) == xs
  prop "groupNonEmptys should contain only equal elements"
    \(xs :: [Int]) -> allEqByNonEmpty (==) $ groupNonEmpty xs

groupByNonEmptySpec :: Spec
groupByNonEmptySpec = describe "groupByNonEmpty" do
  let withPred eq eqName = describeWithFun eqName do
        prop
          do "Concatting after grouping should yield the original list"
          \(xs :: [Int]) -> concatNonEmpty (groupByNonEmpty eq xs) == xs
        prop
          do "Groups should contain only equal elements"
          \(xs :: [Int]) -> allEqByNonEmpty eq $ groupByNonEmpty eq xs

  withPred (==) "default equality"
  withPred ((==) `on` even) "evenness"
  withPred ((==) `on` odd) "oddness"
  withPred ((==) `on` (`div` 13)) "equality (`div` 13)"
  withPred ((==) `on` (`mod` 42)) "equality (`mod` 42)"

groupOnNonEmptySpec :: Spec
groupOnNonEmptySpec = describe "groupOnNonEmpty" do
  let withTransform :: Eq b => (Int -> b) -> String -> Spec
      withTransform f fName = describeWithFun fName do
        prop
          do "Concatting after grouping should yield the original list"
          \(xs :: [Int]) -> concatNonEmpty (groupOnNonEmpty f xs) == xs
        prop
          do "Groups should contain only equal elements"
          \(xs :: [Int]) -> allEqBy (==) $ map (map f . toList) $ groupOnNonEmpty f xs

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"

classifyOnNonEmptySpec :: Spec
classifyOnNonEmptySpec = describe "classifyOn" do
  let withTransform :: Ord b => (Int -> b) -> String -> Spec
      withTransform f fName = describeWithFun fName do
        prop
          do "Classification preserves the elements in the list"
          \(xs :: [Int]) -> xs `sortEq` concatNonEmpty (classifyOnNonEmpty f xs)
        prop
          do "Classification groups contain only equal elements"
          \(xs :: [Int]) -> allEqBy (==) $ map (map f . toList) $ classifyOnNonEmpty f xs

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"
