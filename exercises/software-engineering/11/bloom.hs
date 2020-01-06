import BinaryTree (BinaryTree(Empty, Node))

bloom :: BinaryTree t -> BinaryTree t
bloom Empty = Empty
bloom (Node x Empty Empty) = Node x newLeaf newLeaf
  where newLeaf = Node x Empty Empty
bloom (Node x l r) = Node x (bloom l) (bloom r)
