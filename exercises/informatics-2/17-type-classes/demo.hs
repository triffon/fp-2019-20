import Prelude hiding (Functor, fmap, Maybe, Just, Nothing, Monoid, mappend, mempty, mconcat)

-- data Tree a = Empty | Node (Tree a) a (Tree a)
data Tree a = Empty | Node { left :: Tree a,
                             value :: a,
                             right :: Tree a } deriving (Show, Eq)

data Maybe a = Just a | Nothing deriving Show

find :: (a -> Bool) -> [a] -> Maybe a
find _ [] = Nothing
find p (x:xs)
  | p x = Just x
  | otherwise = find p xs

class YesNo a where
  yesNo :: a -> Bool

instance YesNo Int where
  yesNo 0 = False
  yesNo _ = True

instance YesNo Bool where
  yesNo = id

instance YesNo [a] where
  yesNo [] = False
  yesNo _ = True

instance YesNo (Maybe a) where
  yesNo Nothing = False
  yesNo (Just _) = True

instance YesNo (Tree a) where
  yesNo Empty = False
  -- yesNo (Node _ _ _) = True
  yesNo Node{} = True

class Functor f where
  fmap :: (a -> b) -> f a -> f b


-- Functor Laws:
--  fmap id = id
--  fmap (g . h) = (fmap g) . (fmap h)
instance Functor [] where
  fmap = map

instance Functor Maybe where
  fmap f (Just x) = Just (f x)
  fmap _ Nothing = Nothing

instance Functor Tree where
  fmap _ Empty = Empty
  fmap f Node{left=l, value=v, right=r} =
    Node {left=fmap f l,
          value = f v,
          right = fmap f r}

-- Monoid Laws:
--  mempty `mappend` x = x
--  x `mappend` mempty = x
--  (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)
class Monoid m where
  mempty :: m
  mappend :: m -> m -> m

  mconcat :: [m] -> m
  mconcat = foldr mappend mempty

instance Monoid [a] where
  mempty = []
  mappend = (++)

-- data Product n = Product n
newtype Product n = Product n

-- instance Monoid Integer where
--   mempty = 0
--   mappend = (+)

instance Num n => Monoid (Product n) where
  mempty = Product 1
  (Product a) `mappend` (Product b) = Product (a * b)

main = print ""