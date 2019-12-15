type Vertex = Int
type Graph = [(Vertex, [Vertex])]

vertices :: Graph -> [Vertex]
vertices = concatMap snd

children :: Vertex -> Graph -> [Vertex]
children v g = snd $ head $ filter ((== v) . fst) g

isEdge :: Vertex -> Vertex -> Graph -> Bool
isEdge u v g = u `elem` children v g

parents :: Vertex -> Graph -> [Vertex]
parents v g = [u | u <- vertices g, isEdge u v g]

-- “Семейство” наричаме множество от възли F такова, че за всеки възел u ∈ F е вярно, че във F са всичките му деца и нито един негов родител или всичките му родители и нито едно негово дете.
-- а) (6 т.) Да се реализира функция isFamily, която проверява дали дадено множество от възли е семейство в даден граф;

intersect :: Eq a => [a] -> [a] -> [a]
a `intersect` b = [x | x <- a, x `elem` b]

contains :: Eq a => [a] -> [a] -> Bool
set `contains` subset = all (`elem` set) subset

isDisjointWith :: Eq a => [a] -> [a] -> Bool
a `isDisjointWith` b = null $ a `intersect` b

isFamily :: Graph -> [Vertex] -> Bool
isFamily g set = all isFromFamily set
  where isFromFamily v = onlyChildren || onlyParents
          where onlyChildren = set `contains` allChildren && set `isDisjointWith` allParents
                onlyParents = set `contains` allParents && set `isDisjointWith` allChildren
                allChildren = children v g
                allParents = parents v g

-- б) (10 т.) Да се реализира функция minIncluding, която по даден възел u намира минимално множество от възли, което е семейство и съдържа u (ако такова семейство има).

tails :: [a] -> [[a]]
tails [] = []
tails l = l : tails (tail l)

inits :: [a] -> [[a]]
inits [] = []
inits l = l : inits (init l)

subsequences :: [a] -> [[a]]
subsequences l = [] : [suffix | prefix <- inits l, suffix <- tails prefix]

minBy :: Ord b => (a -> b) -> [a] -> a
minBy _ [] = error "Nothing to compare"
minBy f (h:t) = snd $ foldl comparator (f h, h) t
  where comparator (minValue, minX) x
          | value < minValue = (value, x)
          | otherwise        = (minValue, minX)
            where value = f x

minIncluding :: Graph -> Vertex -> [Vertex]
minIncluding g u = minBy length [s | s <- subsequences $ vertices g,
                                     u `elem` s,
                                     isFamily g s]
