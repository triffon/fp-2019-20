import BinaryTree (BinaryTree(Empty, Node))

maxSumPath :: (Num t, Ord t) => BinaryTree t -> t
maxSumPath Empty = 0
maxSumPath (Node x l r) = x + max (maxSumPath l) (maxSumPath r)
