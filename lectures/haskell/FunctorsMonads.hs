{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE InstanceSigs #-}
module FunctorsMonads where

import GHC.Base (returnIO)

import Prelude hiding (Functor, fmap, (<$>), Applicative, pure, (<*>), sequenceA, (>>=), return, Monad)

import Data (BinTree(..), mapBinTree, foldrBinTree, Tree(..), TreeList(..))

import Main (getInt)

{-
template <typename T>
using List = LinkedList<T>

List<T>
-}

type AssocListDictionary k v = [(k,v)]
type HashMapDictionary k v = [[(k,v)]]
type BinTreeDictionary k v = BinTree (k,v)

type Set d a = d a ()
{-
type AssocListSet a = Set AssocListDictionary a
type HashSet a = Set HashMapDictionary a
type BinTreeSet a = Set BinTreeDictionary a
-}
-- TODO: class Dictionary

class Countable c where
  count :: c a -> Integer

instance Countable [] where
--  count :: [] a -> Integer
  count :: [a] -> Integer
  count = fromIntegral . length

instance Countable Maybe where
  count :: Maybe a -> Integer
  count Nothing  = 0
  count (Just _) = 1

instance Countable BinTree where
  count :: BinTree a -> Integer
  count = foldrBinTree (+) 0 . mapBinTree (const 1)
{-
  count Empty = 0
  count (Node x l r) = 1 + count l + count r
-}

countTrees :: TreeList a -> Integer
countTrees None           = 0
countTrees (SubTree t ts) = count t + countTrees ts

instance Countable Tree where
  count :: Tree a -> Integer
  count (Tree _ ts) = 1 + countTrees ts

{-
instance Countable IO where
  count x = 0
-}

class Listable c where
  elements :: c a -> [a]

instance Listable [] where
--  elements :: [] a -> [a]
  elements :: [a] -> [a]
  elements = id

instance Listable Maybe where
  elements :: Maybe a -> [a]
  elements Nothing = []
  elements (Just x) = [x]

instance Listable BinTree where
  elements :: BinTree a -> [a]
{-
  elements Empty        = []
  elements (Node x l r) = x : elements l ++ elements r
-}
  elements = foldrBinTree (++) [] . mapBinTree (:[])

elementsTrees :: TreeList a -> [a]
elementsTrees None           = []
elementsTrees (SubTree t ts) = elements t ++ elementsTrees ts

instance Listable Tree where
  elements :: Tree a -> [a]
  elements (Tree x ts) = x : elementsTrees ts

class Functor f where
  fmap :: (a -> b) -> f a -> f b
  (<$>) :: (a -> b) -> f a -> f b
  (<$>) = fmap

instance Functor [] where
  fmap :: (a -> b) -> [a] -> [b]
  fmap = map

instance Functor Maybe where
  fmap :: (a -> b) -> Maybe a -> Maybe b
  fmap _ Nothing  = Nothing
  fmap f (Just x) = Just (f x)

-- (a, b) = (,) a b
-- type PairInt a = (Int, a)
-- type PairInt a = (,) Int a
type PairInt = (,) Int
type PairBool = (,) Bool

{-
instance Functor PairInt where
  fmap :: (a -> b) -> PairInt a -> PairInt b
  fmap f (i, x) = (i, f x)

instance Functor PairBool where
  fmap :: (a -> b) -> PairBool a -> PairBool b
  fmap f (i, x) = (i, f x)
-}

instance Functor ((,) c) where
  fmap :: (a -> b) -> (c, a) -> (c, b)
  fmap f (i, x) = (i, f x)

-- TODO: направете (,) a c функтор, където c е фиксиран тип

-- Int -> Bool = (->) Int Bool

instance Functor ((->) r) where
  fmap :: (a -> b) -> (r -> a) -> (r -> b)
  fmap = (.)

instance Functor (Either c) where
  fmap :: (a -> b) -> Either c a -> Either c b
  fmap _ (Left  x) = Left x
  fmap f (Right y) = Right (f y)

-- TODO: Either a c е функтор с фиксирано c и вариращо a

instance Functor BinTree where
  fmap :: (a -> b) -> BinTree a -> BinTree b
  fmap = mapBinTree

fmapTrees :: (a -> b) -> TreeList a -> TreeList b
fmapTrees _ None           = None
fmapTrees f (SubTree t ts) = SubTree (fmap f t) (fmapTrees f ts)

instance Functor Tree where
  fmap :: (a -> b) -> Tree a -> Tree b
  fmap f (Tree x ts) = Tree (f x) (fmapTrees f ts)

instance Functor IO where
  fmap :: (a -> b) -> IO a -> IO b
  fmap f ioa = do x <- ioa
                  returnIO (f x)

-- Just 3 :: Maybe Int
-- a = Int
-- b = Int -> Int
-- (+) :: Int -> (Int -> Int)
-- fmap (+) (Just 3) :: Maybe (Int -> Int)

class Functor f => Applicative f where
  pure  :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  -- fmap g x = (pure g) <*> x
  -- fmap = (<*>) . pure

instance Applicative Maybe where
  pure    = Just
  Nothing <*> _       = Nothing
  _       <*> Nothing = Nothing
  Just f  <*> Just x  = Just $ f x

instance Applicative (Either c) where
  pure :: a -> Either c a
  pure = Right
  (<*>) :: Either c (a -> b) -> Either c a -> Either c b
  Left z  <*> _       = Left z
  _       <*> Left z  = Left z
  Right f <*> Right x = Right (f x)

{-
!!!
instance Applicative ((,) c) where
  pure :: a -> (c, a)
  pure x = (undefined, x)
-}

instance Applicative [] where
  pure :: a -> [a]
  pure = (:[])
  (<*>) :: [a -> b] -> [a] -> [b]
  --fs <*> xs = concat (map (\f -> map (\x -> f x) xs) fs)
  -- fs <*> xs = concatMap (\f -> map (\x -> f x) xs) fs
  -- fs <*> xs = concatMap (`map` xs) fs
  fs <*> xs = [ f x | f <- fs, x <- xs ]

newtype ZipList a = ZipList { getZipList :: [a] }
  deriving (Eq, Ord, Show, Read)

instance Functor ZipList where
  fmap :: (a -> b) -> ZipList a -> ZipList b
  fmap f = ZipList . map f . getZipList

instance Applicative ZipList where
  pure :: a -> ZipList a
  pure = ZipList . (:[])
  (<*>) :: ZipList (a -> b) -> ZipList a -> ZipList b
  zfs <*> zxs = ZipList $ zipWith ($) (getZipList zfs) (getZipList zxs)

instance Applicative ((->) r) where
  pure :: a -> (r -> a)
  pure = const
  (<*>) :: (r -> a -> b) -> (r -> a) -> (r -> b)
  (f <*> g) x = f x (g x)

instance Applicative IO where
  pure :: a -> IO a
  pure = returnIO
  (<*>) :: IO (a -> b) -> IO a -> IO b
  iof <*> iox = do f <- iof
                   x <- iox
                   returnIO $ f x

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f x y = f <$> x <*> y

sequenceA :: (Applicative f) => [f a] -> f [a]
sequenceA []     = pure []
sequenceA (x:xs) = liftA2 (:) x $ sequenceA xs

class (Applicative m) => Monad m where
  return :: a -> m a
  return = pure

  (>>=) :: m a -> (a -> m b) -> m b
  (>>)  :: m a -> m b -> m b
  x >> y   =   x >>= \_ -> y

instance Monad Maybe where
  Nothing >>= _  = Nothing
  Just x  >>= f  = f x

instance Monad [] where
  (>>=) :: [a] -> (a -> [b]) -> [b]
  -- xs >>= f = concatMap f xs
  (>>=) = flip concatMap

instance Monad ((->) r) where
  (>>=) :: (r -> a) -> (a -> r -> b) -> r -> b
  (f >>= g) x = g (f x) x

getAt :: Integer -> [a] -> Maybe a
getAt _ []  = Nothing
getAt 0 (x:_) = Just x
getAt n (_:xs) = getAt (n-1) xs

instance Monad IO where
  iox >>= f = do x <- iox
                 f x
