compress :: Eq t => [t] -> [t]
compress [] = []
compress [x] = [x]
compress (x:y:xs)
  | x == y = compress (y:xs)
  | otherwise = x : compress (y:xs)

compress' :: Eq t => [t] -> [t]
compress' [] = []
compress' (x:xs) = x : compress' (dropWhile (==x) xs)
