module FunctorsMonads where

import Prelude hiding (Functor, fmap, (<$>),
                       Applicative, pure, (<*>), Monad, (>>=))

data Tree a = Empty | Leaf a | Tree { root :: a,
                                      left :: Tree a,
                                      right :: Tree a }
                               deriving (Eq, Show)

type PairsList a b = [(a,b)]

data Figure = Circle Float | Rectangle Float Float

instance Eq Figure where
  Circle x == Circle y               = x == y
  Rectangle w1 h1 == Rectangle w2 h2 = w1 == w2 && h1 == h2
  _ == _                             = False

-- type Player = (String, Int)
-- data Player = Player String Int
data Player = Player { name :: String, score :: Int}

type StringOrInt = Either String Int
f :: Int -> StringOrInt
f x = if even x then Right x else Left "Error"

g :: Int -> Maybe Int
g x = if even x then Just x  else Nothing

-- root x = x + 1

{- !!!
data MyEither a b = MyLeft { extract :: a } |
                    MyRight { extract :: b }
-}

{-
data NamedFigure = NamedCircle { fname :: String,
                                 radius :: Float} |
                   NamedRectangle { fname :: String,
                               width :: Float,
                               height :: Float }
-}

data NamedFigure = NamedCircle String Float |
                   NamedRectangle String Float Float

fname :: NamedFigure -> String
fname (NamedCircle name _) = name
fname (NamedRectangle name _ _) = name

data NamedThing a = NamedThing String a
type NamedFigure2 = NamedThing Figure

class Countable c where
  count :: c a -> Int

instance Countable [] where
  count = length

instance Countable Tree where
  count Empty = 0
  count (Leaf _) = 1
  count (Tree _ lt rt) = 1 + count lt + count rt

class Collectable c where
  collect :: c a -> [a]

instance Collectable [] where
--  collect l = l
  collect = id

instance Collectable Tree where
  collect Empty          = []
  collect (Leaf x)       = [x]
  collect (Tree x lt rt) = x : (collect lt ++ collect rt) -- КЛД

class Functor f where
  fmap :: (a -> b) -> f a -> f b
  (<$>) :: (a -> b) -> f a -> f b
  (<$>) = fmap
  -- fmap id == id

instance Functor [] where
  fmap = map

instance Functor Tree where
  fmap _ Empty           = Empty
  fmap f (Leaf x)        = Leaf (f x)
  fmap f (Tree x lt rt)  = Tree (f x) (fmap f lt) (fmap f rt)

instance Functor Maybe where
  fmap _ Nothing  = Nothing
  fmap f (Just x) = Just (f x)

instance Functor ((->) r) where
--  g :: r -> a
-- f == r -> ?
--  fmap :: (a -> b) -> (f a) -> (f b)
-- f a == r -> a
-- f b == r -> b
--  fmap :: (a -> b) -> (r -> a) -> (r -> b)
--  fmap :: (a -> b) -> (r -> a) -> r -> b
-- x :: r
-- g :: r -> a
-- f :: a -> b
--  fmap f g x = f (g x)
--  fmap f g = f . g
  fmap = (.)

class Functor f => Applicative f where
  pure  :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  -- fmap f x = pure f <*> x
  -- fmap = (<*>) . pure

instance Applicative Maybe where
  pure = Just
--  (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
  Nothing <*> _       = Nothing
  _       <*> Nothing = Nothing
  Just f  <*> Just x  = Just (f x)

instance Applicative [] where
  pure x = [x]
  -- (<*>) :: [a -> b] -> [a] -> [b]
  fs <*> xs = [ f x | f <- fs, x <- xs ]

data ZipList a = ZipList { getZipList :: [a] }
  deriving (Eq, Ord, Show)

instance Functor ZipList where
  -- fmap :: (a -> b) -> ZipList a -> ZipList b
  fmap f (ZipList xs) = ZipList (map f xs)

instance Applicative ZipList where
  pure x = ZipList [x]
  ZipList fs <*> ZipList xs =
     ZipList [ f x | (f, x) <- zip fs xs ]

liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 f x y = f <$> x <*> y

class Applicative m => Monad m where
  return :: a -> m a
  return = pure

  (>>=) :: m a -> (a -> m b) -> m b
  (>>)  :: m a -> m b -> m b
  x >> y = x >>= (\z -> y)

instance Monad Maybe where
  return = Just
  -- (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
  Nothing  >>= _ = Nothing
  (Just x) >>= f = f x

instance Monad [] where
--  return x = [x]
--  return x = x:[]
--  return x = (:[]) x
  return = (:[])

-- (>>=) :: [a] -> (a -> [b]) -> [b]
--  xs >>= f = concat (map f xs)
  xs >>= f = concatMap f xs
