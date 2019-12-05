-- TODO: hoogle
-- TODO: foldl vs foldr, structural recursion, fold paper?

---------------------------- SORTING

-- EXERCISE: Inserting into an ordered list
-- EXAMPLES:
-- insert 5 [1,7,10] -- [1,5,7,10]
-- insert 1337 [1,7,10] -- [1,7,10,1337]
-- insert 69 [] -- [69]
insert :: Integer -> [Integer] -> [Integer]
insert = undefined

-- EXERCISE: Insertion sort
-- Sort a list by taking advantage of the following:
-- 0. [] is a sorted list
-- 1. If xs is a sorted list then insert x xs is also a sorted list
insertionSort :: [Integer] -> [Integer]
insertionSort = undefined

-- EXERCISE: Merging lists
-- Merge two lists that are already sorted
-- merge [1,3,5] [2,4,6] -- merge [1,2,3,4,5,6]
-- merge [1,2,3] [4] -- [1,2,3,4]
merge :: [Integer] -> [Integer] -> [Integer]
merge = undefined

-- EXERCISE: Merge sort
-- Sort a list by taking advantage of the following:
-- 0. We can trivially sort a list with zero or one elements
-- 1. If we split a list in in half, and sort those two halves,
--    then we can use merge to create a new sorted list
mergeSort :: [Integer] -> [Integer]
mergeSort = undefined

-- EXERCISE: Partitioning lists
-- Partition a list according to some predicate.
-- The resulting pair has the elements which satisfy the predicate as its first element,
-- and those that don't as its second element.
-- EXAMPLES:
-- partition even [1..10] -- ([2,4,6,8,10],[1,3,5,7,9])
-- partition (<5) [10,9..0] -- ([4,3,2,1,0],[10,9,8,7,6,5])
partition :: (a -> Bool) -> [a] -> ([a], [a])
partition = undefined

-- EXERCISE: Quicksort
-- Sort a list by taking advantage of the following:
-- If we take a number from a list, let's say p, we sort those smaller than p and those larger than p
-- and then we append these three in that order we will get a sorted list.
quickSort :: [Integer] -> [Integer]
quickSort = undefined

-- EXERCISE: Taking from a list
-- Take elements from the beginning of a list while a predicate holds for them
-- EXAMPLES:
-- takeWhile even [1..10] -- []
-- takeWhile even [1,2,3] -- []
-- takeWhile even [2,4,5,6,8] -- [2,4]
-- takeWhile even [2,4,6,8] -- [2,4,6,8]
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile = undefined

-- EXERCISE: Taking from a list
-- Drop elements from the beginning of a list while a predicate holds for them
-- EXAMPLES:
-- dropWhile even [] -- []
-- dropWhile even [1..10] -- [1,2,3,4,5,6,7,8,9,10]
-- dropWhile even [2,4,6,7,10,12] -- [7,10,12]
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile = undefined

-- EXERCISE: Splitting a list
-- Split a string on a given character
-- Note that String in Haskell is simply [Char]
-- EXAMPLES:
-- splitOn 'a' "" -- []
-- splitOn 'a' "qwertya" --  ["qwerty"]
-- splitOn 'a' "aqwerty" -- ["","qwerty"]
-- splitOn 'a' "abracadabra" --  ["","br","c","d","br"]
splitOn :: Char -> String -> [String]
splitOn = undefined

-- EXERCISE: Grouping
-- Group the numbers which are next to each other and equal to each other
-- group [] -- []
-- group [1,1,1,2,3] -- [[1,1,1],[2],[3]]
-- group [1,1,1,2,3,1,3,3] -- [[1,1,1],[2],[3],[1],[3,3]]
-- group [1..10] -- [[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]]
group :: [Integer] -> [[Integer]]
group = undefined

---------------------------- A#F# INFINITY
-- EXERCISE: Generating all the numbers after a certain one
--
-- EXAMPLES:
-- from 42 -- [42, 43,...]
from :: Integer -> [Integer]
from = undefined

-- EXERCISE: Natural numbers
-- Generate a list of all the natural numbers
naturals :: [Integer]
naturals = undefined

-- EXERCISE: Facts
-- Generate the values of all factorials
-- It's fine to not write an optimised version.
-- The next exercise will be the faster one.
-- [1, 1, 2, 6, 24, 120..]
facts :: [Integer]
facts = undefined

factsFaster :: [Integer]
factsFaster = undefined

-- EXERCISE: Fibs
-- It's fine to not write an optimised version.
-- The next exercise will be the faster one.
-- [0, 1, 1, 2, 3, 5, 8..]
fibs :: [Integer]
fibs = undefined

fibsFaster :: [Integer]
fibsFaster = undefined

-- EXERCISE: 2-tuples
-- Generate a list of all the 2-tuples of natural numbers.
twoTuples :: [(Integer, Integer)]
twoTuples = undefined

-- EXERCISE: Division
-- Check if a number divides another number
-- EXAMPLES:
-- 3 `divides` 5 -- False
-- 3 `divides` 9 -- True
divides :: Integer -> Integer -> Bool
divides = undefined

-- EXERCISE: Check if a number is prime
prime :: Integer -> Bool
prime = undefined

-- EXERCISE: A list of all prime numbers.
-- It's fine to do this naively, we'll try something better next.
primes :: [Integer]
primes = undefined

-- EXERCISE: Faster primes
-- Implement this using the Sieve of Eratosthenes - https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
-- (found below as a task)
-- tl;dr:
-- We can get all the prime numbers using this idea:
-- We will walk through all the natural numbers
-- If we assume the current number n is prime then we can leave it on our list of primes
-- Afterwards we know that all numbers that n divides definitely aren't prime,
-- so we can filter those out from the rest of primes, and then recursively do this
-- procedure to get all prime numbers.
primesFaster :: [Integer]
primesFaster = undefined

-- EXERCISE: Eratosthenes
-- Implement the sieve of eratosthenes
eratosthenes :: [Integer] -> [Integer]
eratosthenes = undefined
