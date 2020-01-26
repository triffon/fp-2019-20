{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveGeneric #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module TrieSpec
  ( spec
  ) where

import Control.Applicative (liftA2)
import Control.Monad (unless)
import Data.Foldable (traverse_)
import Data.Function (on)
import Data.List (nub, sort, nubBy, deleteBy, insertBy, stripPrefix)
import Data.Maybe
import Data.Monoid (All(..))
import Data.Proxy (Proxy(..))
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck
import Test.QuickCheck.Classes (Laws(..), functorLaws, foldableLaws)
import Trie
import GHC.Generics (Generic)

spec :: Spec
spec = describe "Trie tests" $ do
  describe ("instance laws - for reference see " ++ lawsLink) $ do
    lawsToSpec $ functorLaws $ Proxy @Trie
    lawsToSpec $ foldableLaws $ Proxy @Trie

  describe "lookup" $ do
    emptyTrieHasNoElements
    lookupAfterInsertSucceeds
    lookupTrieIsLookup

  describe "insert" $ do
    insertOverwritesOldValue
    insertIsNubByAfterInsertBy

  assocListRoundtrip
  toAssocListSameMapAsList

  describe "subTrie"
    subTrieSameAsParentIfStripped

deriving instance Generic (Trie a)

instance (Arbitrary a) => Arbitrary (Trie a) where
  arbitrary = scale (`rem` 10) $ sized arbitraryTrie
  shrink = genericShrink

arbitraryTrie :: Arbitrary a => Int -> Gen (Trie a)
arbitraryTrie n = do
  val <- arbitrary
  childrenCount <- choose (0, n - 1)
  children <-
    liftA2
      zip
      (nub <$> vectorOf childrenCount arbitrary)
      (vectorOf childrenCount (arbitraryTrie childrenCount))
  pure $ Node {val, children}

emptyTrieHasNoElements :: Spec
emptyTrieHasNoElements = prop "you can't lookup anything in the empty trie" $
  \key -> isNothing $ lookupTrie key $ Node Nothing []

lookupAfterInsertSucceeds :: Spec
lookupAfterInsertSucceeds = prop "lookup after insertion retrieves the inserted element" $
  \(trie :: Trie Int) key val -> Just val == lookupTrie key (insert key val trie)

lookupTrieIsLookup :: Spec
lookupTrieIsLookup = prop "lookupTrie behaves like lookup (for lists) after toAssocList" $
  \(trie :: Trie Int) key -> lookupTrie key trie `shouldBe` lookup key (toAssocList trie)

insertOverwritesOldValue :: Spec
insertOverwritesOldValue = prop "inserting a value for a present key overwrites the old value" $
  \(trie :: Trie Int) key oldVal newVal -> Just newVal == lookupTrie key (insert key newVal $ insert key oldVal trie)

insertIsNubByAfterInsertBy :: Spec
insertIsNubByAfterInsertBy = prop "insert is the same as insertBy for lists (with cleaned up duplicates)" $
  \(trie :: Trie Int) key val ->
    toAssocList (insert key val trie)
    `setOnKeysShouldBe`
    insertBy
      (compare `on` fst)
      (key, val)
      ( deleteBy ((==) `on` fst) (key, error "shouldn't need this")
      $ toAssocList trie
      )

assocListRoundtrip :: Spec
assocListRoundtrip = describe "converting to and from assoc lists" $ do
  prop "to . from == id" $
    \(list :: [(String, Int)]) ->
      let list' = nubBy ((==) `on` fst) list
       in toAssocList (fromAssocList list') `setOnKeysShouldBe` list'

  prop "from . to == id" $
    \(trie :: Trie Int) ->
      let trie' = fromAssocList $ toAssocList trie
       in
        unless (toAssocList trie' `setOnKeysEq` toAssocList trie) $
          expectationFailure $ show trie' ++ "\nshould be the same trie as\n" ++ show trie


toAssocListSameMapAsList :: Spec
toAssocListSameMapAsList = prop "toAssocList creates a trie which contains all the kvs from the list" $
  \(list :: [(String, Int)]) ->
    let list' = nubBy ((==) `on` fst) list
        trie' = fromAssocList list'
     in getAll $ foldMap (\(k, v) -> All $ lookupTrie k trie' == Just v) list'

subTrieSameAsParentIfStripped :: Spec
subTrieSameAsParentIfStripped =
  prop "taking the sub-tries of a trie results in tries that contain values from the original trie,\n\
       \      but with \"stripped\" keys (corresponding to what subtrie you've taken)" $
    \(trie :: Trie Int) ->
      let list = toAssocList trie
          keys = map fst list
          subTrieIsSubset k =
            let subtrie = fromJust $ subTrie k trie
             in
              toAssocList subtrie `setOnKeysShouldBe` mapMaybe (\(k', v) -> (,v) <$> stripPrefix k k') list
       in traverse_ subTrieIsSubset keys

lawsToSpec :: Laws -> Spec
lawsToSpec Laws{lawsTypeclass, lawsProperties} =
  describe (lawsTypeclass ++ " laws") $ traverse_ (uncurry prop) lawsProperties

setOnKeysEq :: (Ord k, Ord v) => [(k, v)] -> [(k, v)] -> Bool
setOnKeysEq = (==) `on` mkSetOnKeys

mkSetOnKeys :: (Ord k, Ord v) => [(k, v)] -> [(k, v)]
mkSetOnKeys = nubBy ((==) `on` fst) . sort

setOnKeysShouldBe :: (Show k, Show v, Ord k, Ord v) => [(k, v)] -> [(k, v)] -> Expectation
setOnKeysShouldBe xs ys =
  unless (xs `setOnKeysEq` ys) $
    expectationFailure $ show xs ++ "\nshould be the same set as\n" ++ show ys

lawsLink :: String
lawsLink = "http://hackage.haskell.org/package/quickcheck-classes-0.6.4.0/docs/Test-QuickCheck-Classes.html"
