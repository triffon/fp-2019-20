-- TODO: newtypes, records
-- TODO: Any, All, Add, Mult, bitvectors, Endo?
-- TODO: Maybe?
-- TODO: Tree?

-- foldmap with this :P
--data Merge a = Merge [a]
--
--getMerge :: Merge a -> [a]
--getMerge (Merge xs) = xs
--
--instance Ord a => Monoid (Merge a) where
--  zero = []
--  Merge x <> Merge y = Merge $ merge x y
--    where
--      merge [] ys = ys
--      merge xs [] = xs
--      merge (x:xs) (y:ys)
--        | x <= y = x : merge xs (y:ys)
--        | otherwise = y : merge (x:xs) ys
