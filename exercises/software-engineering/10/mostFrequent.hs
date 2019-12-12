partition :: (t -> Bool) -> [t] -> ([t], [t])
partition p xs = (filter p xs, filter (not . p) xs)

histogram :: Eq t => [t] -> [(t, Int)]
histogram [] = []
histogram lst@(x:_) = (x, length equals) : histogram unequals
  where (equals, unequals) = partition (==x) lst

intersect :: Eq t => [t] -> [t] -> [t]
xs `intersect` ys = filter (`elem` ys) xs

intersection :: Eq t => [[t]] -> [t]
intersection [] = []
intersection xs = foldl1 intersect xs

mostFrequents :: (Eq t, Num t) => [t] -> [t]
mostFrequents xs = map fst $ filter hasLargestFrequency hist
  where hist = histogram xs
        largestFrequency = maximum $ map snd $ hist
        hasLargestFrequency = (==largestFrequency) . snd

mostFrequent :: (Eq t, Num t) => [[t]] -> t
mostFrequent = headOrZero . intersection . map mostFrequents
  where headOrZero [] = 0
        headOrZero xs = head xs
