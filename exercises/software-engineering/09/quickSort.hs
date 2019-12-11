quickSort :: Ord t => [t] -> [t]
quickSort [] = []
quickSort (pivot:rest) = quickSort smallerOrEqual ++ (pivot : quickSort larger)
  where smallerOrEqual = filter (<=pivot) rest
        larger = filter (>pivot) rest
