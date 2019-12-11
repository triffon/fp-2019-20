{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}

module StuffTest
  ( stuffSpec
  ) where

import Stuff hiding (on, (&&&))

import Data.Function (on)
import Test.Hspec
import Test.Hspec.QuickCheck
import Util

stuffSpec :: Spec
stuffSpec = do
  groupSpec
  sortBySpec
  groupBySpec
  sortOnSpec
  groupOnSpec
  classifyOnSpec

groupSpec :: Spec
groupSpec = describe "group" do
  it "Works on an example" $
    group [1,3,1,2,4,5,1,10,142,42,42,42,69,42,1337,1337]
    `shouldBe`
    [[1],[3],[1],[2],[4],[5],[1],[10],[142],[42,42,42],[69],[42],[1337,1337]]
  prop "Concatting after grouping should yield the original list"
    \(xs :: [Int]) -> concat (group xs) == xs
  prop "Groups shouldn't be empty"
    \(xs :: [Int]) -> all (not . null) $ group xs
  prop "Groups should contain only equal elements"
    \(xs :: [Int]) -> allEqBy (==) $ group xs

sortBySpec :: Spec
sortBySpec = describe "sortBy" do
  let withCmp :: (Int -> Int -> Ordering) -> String -> Spec
      withCmp cmp cmpName = describeWithFun cmpName do
        prop
          do "Sorting preserves the elements in the list"
          \(xs :: [Int]) -> xs `sortEq` sortBy cmp xs
        prop
          do "Sorting creates a sorted list"
          \(xs :: [Int]) ->
            let xs' = sortBy cmp xs
             in all (/=GT) $ zipWith cmp xs' (drop 1 xs')

  withCmp compare "id"
  withCmp (compare `on` even) "even"
  withCmp (compare `on` odd) "odd"
  withCmp (compare `on` (`div` 13)) "(`div` 13)"
  withCmp (compare `on` (`mod` 42)) "(`mod` 42)"

groupBySpec :: Spec
groupBySpec = describe "groupBy" do
  let withPred eq eqName = describeWithFun eqName do
        prop
          do "Concatting after grouping should yield the original list"
          \(xs :: [Int]) -> concat (groupBy eq xs) == xs
        prop
          do "Groups shouldn't be empty"
          \(xs :: [Int]) -> all (not . null) $ groupBy eq xs
        prop
          do "Groups should contain only equal elements"
          \(xs :: [Int]) -> allEqBy eq $ groupBy eq xs

  withPred (==) "default equality"
  withPred ((==) `on` even) "evenness"
  withPred ((==) `on` odd) "oddness"
  withPred ((==) `on` (`div` 13)) "equality (`div` 13)"
  withPred ((==) `on` (`mod` 42)) "equality (`mod` 42)"

sortOnSpec :: Spec
sortOnSpec = describe "sortOn" do
  let withTransform :: Ord b => (Int -> b) -> String -> Spec
      withTransform f fName = describeWithFun fName do
        prop
          do "Sorting preserves the elements in the list"
          \(xs :: [Int]) -> xs `sortEq` sortOn f xs
        prop
          do "Sorting creates a sorted list"
          \(xs :: [Int]) ->
            let xs' = sortOn f xs
             in all (/=GT) $ zipWith (compare `on` f) xs' (drop 1 xs')

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"

groupOnSpec :: Spec
groupOnSpec = describe "groupOn" do
  let withTransform :: Eq b => (Int -> b) -> String -> Spec
      withTransform f fName = describeWithFun fName do
        prop
          do "Concatting after grouping should yield the original list"
          \(xs :: [Int]) -> concat (groupOn f xs) == xs
        prop
          do "Groups shouldn't be empty"
          \(xs :: [Int]) -> all (not . null) $ groupOn f xs
        prop
          do "Groups should contain only equal elements"
          \(xs :: [Int]) -> allEqBy (==) $ map (map f) $ groupOn f xs

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"

classifyOnSpec :: Spec
classifyOnSpec = describe "classifyOn" do
  let withTransform :: Ord b => (Int -> b) -> String -> Spec
      withTransform f fName = describeWithFun fName do
        prop
          do "Classification preserves the elements in the list"
          \(xs :: [Int]) -> xs `sortEq` concat (classifyOn f xs)
        prop
          do "Classification groups shouldn't be empty"
          \(xs :: [Int]) -> all (not . null) $ classifyOn f xs
        prop
          do "Classification groups contain only equal elements"
          \(xs :: [Int]) -> allEqBy (==) $ map (map f) $ classifyOn f xs

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"
