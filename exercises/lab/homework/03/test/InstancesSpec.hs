{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}

module InstancesSpec (spec) where

import Test.Hspec

#ifdef INSTANCES
import Prelude hiding (reverse)
import qualified Prelude as P

import Test.QuickCheck ((==>))
import Test.Hspec.QuickCheck
import Data.Maybe (isJust, isNothing)
import Data.List (group)
import Data.Function (on)

import Instances

spec :: Spec
spec = describe "Instances" do
  pointwiseSpec
  lexicographicSpec
  firstSpec
  lastSpec
  pairSpec
  dualSpec
  fluxSpec

pointwiseSpec :: Spec
pointwiseSpec = describe "Pointwise" do
  let pointwiseLeq = (<=) `on` Pointwise
  prop "fails if one of the components doesn't match the relation" do
    \(x1 :: Int) (y1 :: Int) x2 y2 ->
      x2 < x1 || y2 < y2 ==>
        (x1, y1) `pointwiseLeq` (x2, y2) `shouldBe` False
  it "fails if one of the components doesn't match the relation on examples" do
    (5, 10) `pointwiseLeq` (6, 9) `shouldBe` False
    (5, 10) `pointwiseLeq` (4, 11) `shouldBe` False
  prop "works if both the components match the relation"
    \(x1 :: Int) (y1 :: Int) x2 y2 ->
      x1 <= x2 && y1 <= y2 ==>
        (x1, y1) `pointwiseLeq` (x2, y2) `shouldBe` True
  it "works if both the components match the relation on examples" do
    (5, 10) `pointwiseLeq` (6, 11) `shouldBe` True
    (8, 420) `pointwiseLeq` (69, 1337) `shouldBe` True

lexicographicSpec :: Spec
lexicographicSpec = describe "Lexicographic" do
  let lexicographicLeq = (<=) `on` Lexicographic
  prop "works the same as comparison on the first component if it's bigger" do
    \(x1 :: Int) (y1 :: Int) x2 y2 ->
      x1 < x2 ==>
         (x1, y1) `lexicographicLeq` (x2, y2) `shouldBe` x1 <= x2
  prop "works the same as comparison on the second component if the first is equal" do
    \(x1 :: Int) (y1 :: Int) y2 ->
       (x1, y1) `lexicographicLeq` (x1, y2) `shouldBe` y1 <= y2
  it "works on examples" do
     (1000, 10) `lexicographicLeq` (2, 1337) `shouldBe` False
     (8, 420) `lexicographicLeq` (8, 1337) `shouldBe` True

firstSpec :: Spec
firstSpec = describe "First" do
  prop "if the first one is Just then it ignore the second one" do
    \(mx1 :: Maybe Int) ->
      isJust mx1 ==> First mx1 <> undefined `shouldBe` First mx1
  prop "if the first one is Nothing then it looks at the second one" do
    \(mx2 :: Maybe Int) ->
      First Nothing <> First mx2 `shouldBe` First mx2

lastSpec :: Spec
lastSpec = describe "Last" do
  prop "if the second one is Just then it ignore the first one" do
    \(mx2 :: Maybe Int) ->
      isJust mx2 ==> undefined <> Last mx2 `shouldBe` Last mx2
  prop "if the second one is Nothing then it looks at the first one" do
    \(mx1 :: Maybe Int) ->
      Last mx1 <> Last Nothing `shouldBe` Last mx1

pairSpec :: Spec
pairSpec = describe "Pair" do
  prop "keeps the results of both components" do
    \((x1, y1) :: ([Int], [Int])) (x2, y2) ->
      Pair (x1, y1) <> Pair (x2, y2) `shouldBe` Pair (x1 ++ x2, y1 ++ y2)

dualSpec :: Spec
dualSpec = describe "Dual" do
  prop "flips around operations" do
    \((x1, y1) :: ([Int], [Int])) (x2, y2) ->
      Dual (x1, y1) <> Dual (x2, y2) `shouldBe` Dual (x2 ++ x1, y2 ++ y1)

  prop "reverse works" do
    \(xs :: [Int]) -> P.reverse xs == reverse xs


fluxSpec :: Spec
fluxSpec = describe "Flux" do
  describe "flux (the function) + foldMap" do
    prop "shows no changes on lists of the same thing" do
      \n -> changes (foldMap flux $ replicate n n) `shouldBe` 0
    prop "for a nonempty list: shows changes as many as there are Data.List.groups - 1" do
      \(xs :: [Int]) ->
        not (null xs) ==> changes (foldMap flux xs) `shouldBe` length (group xs) - 1
    it "works on an example" do
      foldMap flux [1,2,1,2,3,3,3,3,4] `shouldBe` Flux (Just (1, 4)) 5
#else
spec :: Spec
spec = describe "Instances" $ it "tests are disabled" $ 
  pendingWith "To enable them run with \"--flag fourth-hw:instances\""
#endif
