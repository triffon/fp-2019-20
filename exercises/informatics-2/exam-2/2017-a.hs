import Data.List (sortOn)

-- variant A

type Point = (Double, Double)

distance :: Point -> Point -> Double
distance (x1, y1) (x2, y2) = sqrt d
  where d = (y2 - y1) ** 2 + (x2 - x1) ** 2

findMedoid :: [Point] -> Point
findMedoid points = head $ sortOn metric points
  where sumOfSquares = sum . map (** 2)
        metric x = sumOfSquares $ map (distance x) points

-- findMedoid [(2,8),(-2,4),(1,2),(-4,-1),(5,0)] → (1,2)

-- fancy pipe operator ;)
(|>) :: t -> (t -> t1) -> t1
x |> f = f x

findMedoid' :: [Point] -> Point
findMedoid' points = points |> sortOn metric |> head
  where metric x = points |> map (distance x) |> map (** 2) |> sum

sumLast :: Int -> Int -> [Int]
sumLast k n = generate initialMemory
  where zeros = [0, 0..]
        initialMemory = k : take (n - 1) zeros
        generate memory = nextNumber : generate nextMemory
           where nextNumber = sum memory
                 nextMemory = tail memory ++ [nextNumber]

data Tree a = Node (Tree a) a (Tree a) | Empty

instance (Show a) => Show (Tree a) where
  show Empty = "()"
  show (Node Empty leaf Empty) = "(" ++ show leaf ++ ")"
  show (Node left root right) = "(" ++ show left ++ ", " ++ show root ++ ", " ++ show right ++ ")"

testTree :: Tree Int
testTree = Node (Node Empty 3 Empty) 1 (Node Empty 2 (Node Empty 5 Empty))

transformCount :: Tree Int -> Tree Int
transformCount tree = fst $ transformCount' tree

transformCount' :: Tree Int -> (Tree Int, Int)
transformCount' Empty = (Empty, 0)
transformCount' (Node Empty _ Empty) = (Node Empty 1 Empty, 1)
transformCount' (Node left _ right) = (newTree, count)
  where (newLeftTree, leftCount) = transformCount' left
        (newRightTree, rightCount) = transformCount' right
        count = 1 + leftCount + rightCount
        newTree = Node newLeftTree count newRightTree

main :: IO ()
main = print ":)"
