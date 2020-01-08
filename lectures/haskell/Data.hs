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
today :: Weekday
today = Wed
isWeekend Sat = True
isWeekend Sun = True
isWeekend _   = False

data Player = Player { name :: String, score :: Int }
katniss :: Player
katniss = Player "Katniss Everdeen" 45

better (Player name1 score1) (Player name2 score2)
 | score1 > score2 = name1
 | otherwise       = name2

mario :: Player
mario = Player { score = 55, name = "Mario" }
