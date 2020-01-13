import BinaryTree (BinaryTree(Empty, Node))

intervalTree :: (Num t, Ord t) => BinaryTree t -> BinaryTree (t, t)
intervalTree Empty = Empty
intervalTree (Node x l r) = Node (interval x l' r') l' r'
  where l' = intervalTree l
        r' = intervalTree r
        interval x Empty Empty = (x, x)
        interval x (Node (y', y'') _ _) Empty = (min x y', max x y'')
        interval x Empty (Node (y', y'') _ _) = (min x y', max x y'')
        interval x (Node (y', y'') _ _) (Node (z', z'') _ _) =
          (minimum [x, y', z'], maximum [x, y'', z''])
