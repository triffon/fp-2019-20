module Random
  ( Gen
  , theGen
  , randomInt
  ) where

import System.IO.Unsafe (unsafePerformIO)
import System.Random (StdGen, newStdGen, random)
import Data.Tuple (swap)

newtype Gen = Gen {getGen :: StdGen}

-- don't rely on DerivingStrategies being present
instance Show Gen where
  show = show . getGen

randomInt :: Gen -> (Gen, Int)
randomInt = first Gen . swap . random . getGen

-- don't rely on Data.Bifunctor (first) being present
first :: (a -> c) -> (a, b) -> (c, b)
first f (x, y) = (f x, y)





















































theGen :: Gen
theGen = Gen $ unsafePerformIO newStdGen
{-# NOINLINE theGen #-}
