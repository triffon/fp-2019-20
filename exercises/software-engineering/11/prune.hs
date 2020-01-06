import BinaryTree (BinaryTree(Empty, Node))

prune :: BinaryTree t -> BinaryTree t
prune Empty = Empty
prune (Node _ Empty Empty) = Empty
prune (Node x l r) = Node x (prune l) (prune r)
