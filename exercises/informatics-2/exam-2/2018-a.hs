import Prelude hiding (shows)
import Data.List (nub, inits, tails, sortOn)

-- variant A

-- task 1
-- mostFrequent [[1,1,3,2],[1,1,5],[1,5],[1,1,1,3]] → 1
-- mostFrequent [[1,1,3,2],[1,5,5],[1,5],[1,1,1,3]] → 0

intersect :: (Eq a) => [a] -> [a] -> [a]
intersect a b = [x | x <- a, x `elem` b]

mostFrequent :: (Num a, Ord a) => [[a]] -> a
mostFrequent ll = let
    candidates = foldl1 intersect . map mostFrequentInList $ ll
  in case candidates of
     [] -> 0
     [winner] -> winner
     _ -> 0

mostFrequentInList :: (Num a, Ord a) => [a] -> [a]
mostFrequentInList [] = []
mostFrequentInList l = let
     count x = length . filter (== x)
     unique = nub l
     counts = map (`count` l) unique
     histogram = unique `zip` counts
     maximumCount = maximum counts
  in map fst $ filter ((== maximumCount) . snd) histogram

-- task 2

data Tree a = Node (Tree a) a (Tree a) | Empty

instance (Show a) => Show (Tree a) where
  show Empty = ""
  show (Node Empty leaf Empty) = "(" ++ show leaf ++ ")"
  show (Node left root right) = "(" ++ show left ++ ", " ++ show root ++ ", " ++ show right ++ ")"

makeLeaf :: a -> Tree a
makeLeaf x = Node Empty x Empty

grow :: Tree a -> a -> Tree a
grow Empty _ = Empty
grow (Node Empty root Empty) x = Node (makeLeaf x) root (makeLeaf x)
grow (Node left root right) x = Node (grow left x) root (grow right x)

growingTrees :: [Tree Integer]
growingTrees = generate (Node Empty 1 Empty) 2
  where generate tree n = tree : generate (grow tree n) (n + 1)

-- **Задача 3.** Телевизионно предаване се представя с наредена тройка от име (низ), начален час (наредена двойка от час и минути) и продължителност (брой минути). Телевизионна програма наричаме последователност от предавания, чиито интервали на излъчвания са подредени в нарастващ ред и не се пресичат.

-- - (5 т.) Да се напише ункция `lastShow`, което по списък от предавания връща името на това, което завършва най-късно.

-- - (10 т.) Да се напише функция `longestProgram`, която по даден списък от предавания генерира възможно най-дълга телевизионна програма, т.е. сумата от продължителностите на предаванията в нея е максимална.

-- Примери:

type Name = String
type Hour = Integer
type Minute = Integer
type StartTime = (Hour, Minute)
type Duration = Integer
type TvShow = (Name, StartTime, Duration)

shows :: [TvShow]
shows = [("A", (11, 0), 120),
         ("B", (12, 0), 15),
         ("C", (10, 30), 90)]

lastShow :: [TvShow] -> Name
lastShow [] = error "No shows"
lastShow tvShows = let
     computeEndTime (name, (hours, minutes), duration) =
       (name, hours * 60 + minutes + duration)
     endTimes = map computeEndTime tvShows
     maxEndTime = maximum $ map snd endTimes
  in fst $ head $ filter ((== maxEndTime) . snd) endTimes

-- lastShow shows → "A"

subsequences :: [a] -> [[a]]
subsequences l = [] : [suffix | prefix <- inits l,
                                suffix <- tails prefix,
                                not $ null suffix]

areDisjoint :: TvShow -> TvShow -> Bool
areDisjoint (_, (h1, m1), d1) (_, (h2, m2), _) = firstShowEnd < secondShowStart
  where firstShowEnd = h1 * 60 + m1 + d1
        secondShowStart = h2 * 60 + m2

areDisjoint' :: [TvShow] -> Bool
areDisjoint' [] = True
areDisjoint' [_] = True
areDisjoint' (show:rest) = showIsDisjoint && areDisjoint' rest
  where showIsDisjoint = all (areDisjoint show) rest

longestProgram :: [TvShow] -> [TvShow]
longestProgram shows = head $ filter ((== maxDuration) . getTotalDuration) programs
  where getStartMinutes (_, (h, m), _) = h * 60 + m
        sortedShows = sortOn getStartMinutes shows
        programs = [s | s <- subsequences sortedShows, areDisjoint' s]
        getDuration (_, _, duration) = duration
        getTotalDuration = sum . map getDuration
        maxDuration = maximum . map getTotalDuration $ programs

-- longestProgram shows → [("A",(11,0),120))]

main :: IO ()
main = print ":)"
