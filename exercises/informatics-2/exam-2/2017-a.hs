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


main :: IO ()
main = print ":)"
