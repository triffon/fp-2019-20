{-# LANGUAGE InstanceSigs #-} -- allows us to write signatures in instance declarations
{-# LANGUAGE RankNTypes #-} -- ignore this
{-# LANGUAGE DeriveFunctor #-} -- ignore this
{-# LANGUAGE DeriveFoldable #-} -- ignore this

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Foldable(..), Functor(..), Either(..))
import Data.Monoid (Endo(..))

-- ask about bonus exercises

-- mention aggressive polymorphism
--
-- explain kinds?
-- can write Int
-- can write Maybe Int
-- can't write Maybe, why?
--
-- examples!!!@#@!#!@#!
type Id a = a
-- :k Id
-- Type -> Type
--
newtype Identity a = Identity a
  deriving Show


newtype Const a b = Const a
  deriving Show

type Apply f a = f a
-- Apply :: (Type -> Type) -> Type -> Type
-- IntContainer (?)

-- example (?):
-- user age name
-- incomplete user

--
-- motivation:
-- same funs for List, Maybe, Tree
-- abstract away
-- imba
--
--
-- fmap f . fmap g == fmap (f . g)
-- fmap id == id
--class Functor f where
--  fmap :: (a -> b) -> f a -> f b
--
--map' :: (a -> b) -> [a] -> [b]
--map' = map
--
--instance Functor [] where
--  fmap = map'
--
--mapMaybe :: (a -> b) -> Maybe a -> Maybe b
--mapMaybe _ Nothing = Nothing
--mapMaybe f (Just x) = Just (f x)
--
--instance Functor Maybe where
--  fmap = mapMaybe
--
--instance Functor Tree where
--  fmap = mapTree
--
--mapTree :: (a -> b) -> Tree a -> Tree b
--mapTree _ Empty = Empty
--mapTree f (Node l x r) = Node (mapTree f l) (f x) (mapTree f r)

--data Tree a
--  = Empty
--  | Node (Tree a) a (Tree a)
--  deriving (Show, Eq, Ord, Functor, Foldable)

--class Foldable f where
--  foldMap :: Monoid m => (a -> m) -> f a -> m
--
--foldMap' :: Monoid m => (a -> m) -> [a] -> m
--foldMap' = undefined
--foldMapMaybe' :: Monoid m => (a -> m) -> Maybe a -> m
--foldMapMaybe' = undefined
--foldMapTree' :: Monoid m => (a -> m) -> Tree a -> m
--foldMapTree' = undefined
--
--foldr' :: (a -> b -> b) -> b -> [a] -> b
--foldr' = undefined




--
-- functor, foldable
-- https://wiki.haskell.org/Typeclassopedia
--
-- show deriving functor + foldable 8-)
-- for List, Maybe, Tree?
--
-- https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Foldable.html#g:5
--
-- hide functor and foldable!!!!!
-- and uncomment these

-- laws:
-- fmap id == id
-- fmap f . fmap g == id
class Functor f where
  fmap :: (a -> b) -> f a -> f b

(<$>) :: Functor f => (a -> b) -> f a -> f b
(<$>) = fmap

infixl 4 <$>

class Foldable f where
  foldr :: (a -> b -> b) -> b -> f a -> b
  foldr f v xs = appEndo (foldMap (Endo . f) xs) v

  foldMap :: Monoid m => (a -> m) -> f a -> m
  foldMap f xs = foldr ((<>) . f) mempty xs

instance Functor Identity where
  fmap :: (a -> b) -> Identity a -> Identity b
  fmap = undefined

instance Functor [] where
  fmap :: (a -> b) -> [a] -> [b]
  fmap = undefined

instance Functor Maybe where
  fmap :: (a -> b) -> Maybe a -> Maybe b
  fmap = undefined

instance Functor (Const c) where
  fmap :: (a -> b) -> Const c a -> Const c b
  fmap = undefined

-- like maybe, but you can store something in the "nothing" case
-- this is very commonly used to report errors,
-- instead of returning just a Maybe a,
-- we return an Either e a
-- and we say something like
-- Left "out of bounds"
-- which is way more descriptive than Nothing
data Either a b
  = Left a
  | Right b
  deriving (Show, Eq)

instance Functor (Either e) where
  fmap :: (a -> b) -> Either e a -> Either e b
  fmap = undefined

instance Functor ((,) w) where
  fmap :: (a -> b) -> (w, a) -> (w, b)
  fmap = undefined

instance Functor ((->) r) where
  fmap :: (a -> b) -> (r -> a) -> (r -> b)
  fmap = undefined

(<$) :: Functor f => a -> f b -> f a
(<$) = undefined

($>) :: Functor f => a -> f b -> f a
($>) = undefined

void :: Functor f => f a -> f ()
void = undefined

-- difficulty = a lot
newtype Cont a = Cont {runCont :: forall r. (a -> r) -> r}

toId :: Cont a -> a
toId = undefined

fromId :: a -> Cont a
fromId = undefined

instance Functor Cont where
  fmap :: (a -> b) -> Cont a -> Cont b
  fmap = undefined
