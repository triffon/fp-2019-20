-- nub
-- за списък от числа, премахва дубликатите
nub :: (Eq a) => [a] -> [a]
nub (x:xs) = x : (filter (/=x) xs)

-- quicksort
-- Няма нужда да взимаме случаен елемент
-- просто можем да вземем първия
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =  lower ++ [x] ++ higher
  where lower = quicksort [y | y<-xs, y <= x]
        higher = quicksort [y | y<-xs, y > x]

-- prime?
prime :: Int -> Bool
prime n = null [x | x<-[2..n-1], n `rem` x == 0]

-- primes
-- За дадено число n връща списък от първите n прости числа
primes :: Int -> [Int]
primes n = take n $ filter prime [1..]
