maximumBy :: Ord b => (a -> b) -> [a] -> a
maximumBy fn = foldl1 (maxBy fn)
  where maxBy fn x y
          | fn y > fn x = y
          | otherwise = x

sortBy :: Ord b => (a -> b) -> [a] -> [a]
sortBy _ [] = []
sortBy fn (pivot:rest) = sortBy fn smallerOrEqual ++ (pivot : sortBy fn larger)
  where smallerOrEqual = filter (`compare`pivot) rest
        larger = filter (not . (`compare`pivot)) rest
        compare x y = fn x <= fn y

quickSort :: Ord t => [t] -> [t]
quickSort [] = []
quickSort (pivot:rest) = quickSort smallerOrEqual ++ (pivot : quickSort larger)
  where smallerOrEqual = filter (<=pivot) rest
        larger = filter (>pivot) rest

combinations :: [t] -> [[t]]
combinations [] = [[]]
combinations (x:xs) = includingHead ++ withoutHead
  where withoutHead = combinations xs
        includingHead = map (x:) withoutHead

type TvShow = (String, (Int, Int), Int)

name :: TvShow -> String
name (x, _, _) = x

duration :: TvShow -> Int
duration (_, _, x) = x

startMinutes :: TvShow -> Int
startMinutes (_, (hours, minutes), _) = hours * 60 + minutes

endMinutes :: TvShow -> Int
endMinutes tvShow = startMinutes tvShow + duration tvShow

lastShow :: [TvShow] -> String
lastShow = name . maximumBy endMinutes

programDuration :: [TvShow] -> Int
programDuration = sum . map duration

startsAfter :: TvShow -> TvShow -> Bool
firstShow `startsAfter` secondShow =
  startMinutes firstShow > endMinutes secondShow

isProgram :: [TvShow] -> Bool
isProgram [] = True
isProgram [_] = True
isProgram (firstShow : secondShow : rest) =
  secondShow `startsAfter` firstShow && isProgram (secondShow : rest)

longestProgram :: [TvShow] -> [TvShow]
longestProgram = maximumBy programDuration . programs
  where sortedCombinations = map (sortBy startMinutes) . combinations
        programs = filter isProgram . sortedCombinations
