{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Stuff

import Data.Function (on)
import Test.Hspec
import Test.Hspec.QuickCheck

main :: IO ()
main = hspec do
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
  pure ()

groupBySpec :: Spec
groupBySpec = describe "groupBy" do
  let withPred eq eqName = do
        prop
          do "Concatting after grouping should yield the original list when using " ++ eqName
          \(xs :: [Int]) -> concat (groupBy eq xs) == xs
        prop
          do "Groups shouldn't be empty when using " ++ eqName
          \(xs :: [Int]) -> all (not . null) $ groupBy eq xs
        prop
          do "Groups should contain only equal elements when using " ++ eqName
          \(xs :: [Int]) -> allEqBy eq $ groupBy eq xs

  withPred (==) "default equality"
  withPred ((==) `on` even) "evenness"
  withPred ((==) `on` odd) "oddness"
  withPred ((==) `on` (`div` 13)) "equality (`div` 13)"
  withPred ((==) `on` (`mod` 42)) "equality (`mod` 42)"

sortOnSpec :: Spec
sortOnSpec = pure ()

groupOnSpec :: Spec
groupOnSpec = describe "groupOn" do
  let withTransform :: Eq b => (Int -> b) -> String -> Spec
      withTransform f fName = do
        prop
          do "Concatting after grouping should yield the original list when using " ++ fName
          \(xs :: [Int]) -> concat (groupOn f xs) == xs
        prop
          do "Groups shouldn't be empty when using " ++ fName
          \(xs :: [Int]) -> all (not . null) $ groupOn f xs
        prop
          do "Groups should contain only fual elements when using " ++ fName
          \(xs :: [Int]) -> allEqBy (==) $ map (map f) $ groupOn f xs

  withTransform id "id"
  withTransform even "even"
  withTransform odd "odd"
  withTransform (`div` 13) "(`div` 13)"
  withTransform (`mod` 42) "(`mod` 42)"

classifyOnSpec :: Spec
classifyOnSpec = pure ()

allEqBy :: (a -> a -> Bool) -> [[a]] -> Bool
allEqBy eq = all (\ys -> let y' = head ys in all (eq y') ys)
