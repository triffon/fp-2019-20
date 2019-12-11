cycle' :: [t] -> [t]
cycle' [] = []
cycle' xs = iter xs
  where iter [] = iter xs
        iter (x:xs) = x : iter xs
