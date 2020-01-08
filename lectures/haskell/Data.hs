module Data where

type MathFun = Double -> Double
type UnaryFunction a = a -> a
type Dictionary k v = [(k,v)]

class Measurable a where
  size :: a -> Int
  empty :: a -> Bool
  empty = (==0) . size

larger :: Measurable a => a -> a -> Bool
larger x y = size x > size y

instance Measurable Integer where
  size 0 = 0
  size n = 1 + size (n `div` 10)

instance (Measurable a, Measurable b) => Measurable (a,b) where
  size (x,y) = size x + size y

instance Measurable a => Measurable [a] where
  size = sum . map size

data Weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
  deriving (Eq, Ord, Show, Enum, Read)
today :: Weekday
today = Wed
isWeekend Sat = True
isWeekend Sun = True
isWeekend _   = False

data Player = Player { name :: String, score :: Int }
  deriving (Eq, Ord, Show, Read)
katniss :: Player
katniss = Player "Katniss Everdeen" 45

better (Player name1 score1) (Player name2 score2)
 | score1 > score2 = name1
 | otherwise       = name2

mario :: Player
mario = Player { score = 55, name = "Mario" }

data Nat = Zero | Succ Nat deriving (Eq, Ord, Read, Show)
five = Succ $ Succ $ Succ $ Succ $ Succ $ Zero

fromNat :: Nat -> Int
fromNat Zero     = 0
fromNat (Succ n) = 1 + fromNat n

toNat :: Int -> Nat
-- toNat 0 = Zero
-- toNat n = Succ $ toNat $ n - 1
toNat = (iterate Succ Zero !!)

data Bin = One | BitZero Bin | BitOne Bin deriving (Eq, Ord, Show, Read)
six = BitZero $ BitOne $ One

fromBin :: Bin -> Int
fromBin One         = 1
fromBin (BitZero b) = 2 * fromBin b
fromBin (BitOne b)  = 2 * fromBin b + 1

-- toBin :: Int -> Bin

succBin :: Bin -> Bin
succBin One         = BitZero One
succBin (BitZero b) = BitOne b
succBin (BitOne b)  = BitZero (succBin b)

data List a = Nil | Cons a (List a) deriving (Eq, Ord, Read, Show)
l = Cons 1 $ Cons 2 $ Cons 3 Nil

nullList :: List a -> Bool
nullList Nil = True
nullList _   = False

headList :: List a -> a
headList (Cons x _) = x

tailList :: List a -> List a
tailList (Cons _ xs) = xs

fromList :: List a -> [a]
fromList Nil         = []
fromList (Cons x xs) = x : fromList xs 

(+++) :: List a -> List a -> List a
Nil         +++ l = l
(Cons x xs) +++ l = Cons x (xs +++ l)

data BinTree a = Empty | Node { root :: a, left :: BinTree a, right :: BinTree a }
  deriving (Eq, Ord, Read, Show)

leaf x = Node x Empty Empty
t = Node 1 (leaf 2) (Node 3 (leaf 4) (leaf 5))

depth :: BinTree a -> Int
depth Empty        = 0
depth (Node x l r) = 1 + max (depth l) (depth r)

leaves :: BinTree a -> [a]
leaves Empty        = []
leaves (Node x Empty Empty) = [x]
leaves (Node x l r) = leaves l ++ leaves r 

mapBinTree :: (a -> b) -> BinTree a -> BinTree b
mapBinTree f Empty        = Empty
mapBinTree f (Node x l r) = Node (f x) (mapBinTree f l) (mapBinTree f r)

foldrBinTree :: (a -> a -> a) -> a -> BinTree a -> a
foldrBinTree _  nv Empty        = nv
foldrBinTree op nv (Node x l r) = op x (op (foldrBinTree op nv l) (foldrBinTree op nv r))
