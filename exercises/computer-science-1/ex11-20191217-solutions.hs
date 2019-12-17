import Data.List (sortBy)
import Data.Ord (comparing)

-- Пример за генериране на поток, при който всяка стойност
-- зависи от предишните (напр. е равна на сумата им)
f x = x : helper [x]
  where helper previous = let s = sum previous
                          in s : helper (previous ++ [s])

forestFire = map helper [0..]
  where helper n = head [ x | x<-[1..],
                              not (any (\k -> isAritm k n x) [1..n`div`2])]
          where isAritm k n x = 2*(helper (n-k)) == (helper (n-2*k)) + x

forestFire2 = 1 : helper [1] 1
  -- На всяко извикване на helper previous са всички досега генерирани числа,
  -- а n е индексът на следващото за генериране число (той съвпада с length previous)
  where helper previous n =
          let s = head [ x | x<-[1..], not (any (\k -> isAritm k x) [1..n`div`2])]
          in s : helper (previous++[s]) (n+1)
            where isAritm k x = 2*(previous!!(n-k)) == (previous!!(n-2*k)) + x

setUnion :: Ord a => [a] -> [a] -> [a]
setUnion [] ys = ys
setUnion xs [] = xs
setUnion (x:xs) (y:ys)
  | x < y     = x : setUnion xs (y:ys)
  | x > y     = y : setUnion (x:xs) ys
  | otherwise = x : setUnion xs ys

setIntersect :: Ord a => [a] -> [a] -> [a]
setIntersect xs ys = [ x | x<-xs, x `elem` ys]

setDiff2 xs ys = [ x | x<-xs, not $ x `elem` ys]

setDiff [] ys = []
setDiff xs [] = xs
setDiff (x:xs) (y:ys)
  | x < y     = x : setDiff xs (y:ys)
  | x > y     = setDiff (x:xs) ys
  | otherwise = setDiff xs ys

compress :: Eq a => [a] -> [(a,Int)]
compress = undefined

maxRepeated :: Eq a => [a] -> Int
maxRepeated = maximum . map snd . compress

-- За pretty-print използвайте mapM_ print $ crossOut ...
crossOut :: [[a]] -> [[[a]]]
crossOut mat = [ removeRowAndCol i j mat | i<-[0..n-1], j<-[0..m-1] ]
  where n = length mat
        m = length (head mat)
        removeAtIndex i lst = take i lst ++ drop (i+1) lst
        removeRowAndCol i j mat = map (\row -> removeAtIndex j row)
                                      (removeAtIndex i mat)

mostCommon :: Ord a => [a] -> a
mostCommon = undefined

specialSort :: Ord a => [[a]] -> [[a]]
specialSort lst = sortBy (comparing mostCommon) lst