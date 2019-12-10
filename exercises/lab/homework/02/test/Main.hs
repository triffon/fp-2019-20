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
  prop "Works the same way as group when using the default (==)"
    \(xs :: [Int]) -> groupBy (==) xs == group xs

  let withPred eq eqName = do
        it
          do "Works on an example when using " ++ eqName
          do groupBy eq [1,3,1,2,4,5,1,10,142,42,42,42,69,42,1337,1337]
               `shouldBe`
               [[1,3,1],[2,4],[5,1],[10,142,42,42,42],[69],[42],[1337,1337]]
        prop
          do "Concatting after grouping should yield the original list when using " ++ eqName
          \(xs :: [Int]) -> concat (groupBy eq xs) == xs
        prop
          do "Groups shouldn't be empty when using " ++ eqName
          \(xs :: [Int]) -> all (not . null) $ groupBy eq xs
        prop
          do "Groups should contain only equal elements when using " ++ eqName
          \(xs :: [Int]) -> allEqBy eq $ groupBy eq xs

  withPred ((==) `on` even) "evenness"
  withPred ((==) `on` odd) "oddness"

sortOnSpec :: Spec
sortOnSpec = pure ()

groupOnSpec :: Spec
groupOnSpec = describe "groupOn" do
  prop "Works the same way as group when using the default id"
    \(xs :: [Int]) -> groupOn id xs == group xs

  let withPred :: Eq b => (Int -> b) -> String -> Spec
      withPred f fName = do
        it
          do "Works on an example when using " ++ fName
          do groupOn f [1,3,1,2,4,5,1,10,142,42,42,42,69,42,1337,1337]
               `shouldBe`
               [[1,3,1],[2,4],[5,1],[10,142,42,42,42],[69],[42],[1337,1337]]
        prop
          do "Concatting after grouping should yield the original list when using " ++ fName
          \(xs :: [Int]) -> concat (groupOn f xs) == xs
        prop
          do "Groups shouldn't be empty when using " ++ fName
          \(xs :: [Int]) -> all (not . null) $ groupOn f xs
        prop
          do "Groups should contain only fual elements when using " ++ fName
          \(xs :: [Int]) -> allEqBy (==) $ map (map f) $ groupOn f xs

  withPred even "even"
  withPred odd "odd"

classifyOnSpec :: Spec
classifyOnSpec = pure ()

allEqBy :: (a -> a -> Bool) -> [[a]] -> Bool
allEqBy eq = all (\ys -> let y' = head ys in all (eq y') ys)
