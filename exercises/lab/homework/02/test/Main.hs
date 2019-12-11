{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE CPP #-}

module Main
  ( main
  ) where

import Stuff hiding (on, (&&&))
import StuffNonEmpty

import Data.List (sort)
import Data.Function (on)
import Test.Hspec
import Test.Hspec.QuickCheck
import StuffTest (stuffSpec)
import StuffNonEmptyTest (stuffNonEmptySpec)
import Util

main :: IO ()
main = hspec do
  stuffSpec
#ifdef NONEMPTY
  stuffNonEmptySpec
#endif
