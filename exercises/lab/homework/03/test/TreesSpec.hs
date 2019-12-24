{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# OPTIONS_GHC -fno-warn-incomplete-uni-patterns #-}

module TreesSpec (spec) where

import Test.Hspec

#ifdef TREES
import Test.Hspec.QuickCheck
import Test.QuickCheck
import Data.Maybe
import Data.List (sort, nub)
import Data.Function (on)

import Trees

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = scale (`rem` 10) $ sized sizedTree
    where
      sizedTree :: Int -> Gen (Tree a)
      sizedTree 0 = pure Empty
      sizedTree n = Node <$> arbitrary <*> sizedTree (n - 1) <*> sizedTree (n - 1)

spec :: Spec
spec = describe "Trees" do
  modifyMaxDiscardRatio (const 20000) $ modifyMaxSize (const 2) $ modifyMaxSuccess (const 5) $
    eqSpec
  bstSpec
  listSpec
  foldLikeSpec
  validateTreeSpec
  pathsSpec

eqSpec :: Spec
eqSpec = describe "equality" do
  prop "reflexive" do
    \(tree :: Tree Int) -> tree == tree
  prop "symmetric" do
    \(tree1 :: Tree Int) tree2 -> tree1 == tree2 ==> tree2 == tree1
  prop "transitive" do
    \(tree1 :: Tree Int) tree2 tree3 ->
      tree1 == tree2 && tree2 == tree3 ==> tree1 == tree3

bstSpec :: Spec
bstSpec = describe "BST ordering stuff" do
  prop "listToBST should create a BST according to isBST"
    \(xs :: [Int]) -> isBST $ listToBST xs
  prop "inserting in a BST should maintain BST-ness"
    \(xs :: [Int]) x -> isBST $ insertOrdered x $ listToBST xs
  prop "treeToList . listToBST should sort the list"
    \(xs :: [Int]) -> treeToList (listToBST xs) `shouldBe` sort xs
  prop "you can find all the elements from which a BST was made in it"
    \(xs :: [Int]) -> let tree = listToBST xs in all (`findBST` tree) xs
  prop "all the elements in the left/right subtree are <=/> than the root"
    \(xs :: [Int]) ->
      let tree = listToBST xs
       in isNode tree ==>
         let Node x l r = tree
          in allTree (<=x) l && allTree (>x) r

listSpec :: Spec
listSpec = describe "list stuff" do
  prop "treeToList . listToBST produces the original list (after sorting)"
    \(xs :: [Int]) -> sort xs == sort (treeToList $ listToBST xs)
  describe "listToBST" do
    prop "all the elements of the tree are elements of the original list"
      \(xs :: [Int]) -> allTree (`elem` xs) $ listToBST xs
    prop "all the elements of the original list are elements of the tree"
      \(xs :: [Int]) -> let tree = listToBST xs in all (`elemTree` tree) xs
  describe "treeToList" do
    prop "all the elements of the original tree are elements of the list"
      \(tree :: Tree Int) -> let xs = treeToList tree in allTree (`elem` xs) tree
    prop "all the elements of the list are elements of the original tree"
      \(tree :: Tree Int) -> let xs = treeToList tree in all (`elemTree` tree) xs
  prop "treeToList . mapTree is the same as map . treeToList"
    \(tree :: Tree Int) (Fn f :: Fun Int Int) ->
      treeToList (mapTree f tree) `shouldBe`
      map f (treeToList tree)

foldLikeSpec :: Spec
foldLikeSpec = describe "fold-like functions" do
  prop "sumTree behaves like sum"
    \(tree :: Tree Int) -> sumTree tree == sum (treeToList tree)
  prop "elemTree behaves like elem"
    \x (tree :: Tree Int) -> elemTree x tree == elem x (treeToList tree)
  prop "allTree behaves like all"
    \(Fn p :: Fun Int Bool) (tree :: Tree Int) ->
      allTree p tree == all p (treeToList tree)
  prop "findAll behaves like list find all"
    \(Fn p :: Fun Int Bool) (tree :: Tree Int) ->
      sort (findAll p tree) == sort [x | x <- treeToList tree, p x]

validateTreeSpec :: Spec
validateTreeSpec = describe "validateTree" do
  modifyMaxSuccess (*200) $ -- because we get Nothing 99.9% of the time
    prop "validateTree behaves like traverse on lists" do
      \(tree :: Tree Int) (Fn f :: Fun Int (Maybe Int)) ->
        fmap (sort . treeToList) (validateTree f tree)
        `shouldBe` fmap sort (traverse f $ treeToList tree)

  prop "the always true validation returns the original tree" do
    \(tree :: Tree Int) ->
      validateTree Just tree `shouldBe` Just tree

  prop "the always false validation returns Nothing" do
    \(tree :: Tree Int) ->
      isNode tree ==>
        validateTree (const Nothing) tree `shouldBe` (Nothing :: Maybe (Tree Int))

pathsSpec :: Spec
pathsSpec = describe "paths" do
  prop "you can 'fetch' the original elements by using the paths returned from 'paths'"
    \(tree :: Tree Int) -> all (\(x, pathx) -> fetch pathx tree == Just x) $ paths tree

isNode :: Tree a -> Bool
isNode Empty = False
isNode _ = True
#else
spec :: Spec
spec = describe "Trees" $ it "tests are disabled" $
  pendingWith "To enable them run with \"--flag fourth-hw:trees\""
#endif
