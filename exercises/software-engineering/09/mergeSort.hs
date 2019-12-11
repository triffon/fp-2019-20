mergeSort :: Ord t => [t] -> [t]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = mergeSort firstHalf `merge` mergeSort secondHalf
  where mid = length xs `quot` 2
        (firstHalf, secondHalf) = splitAt mid xs
        merge [] xs = xs
        merge xs [] = xs
        merge (x:xs) (y:ys)
          | y < x = y : merge (x:xs) ys
          | otherwise = x : merge xs (y:ys)
