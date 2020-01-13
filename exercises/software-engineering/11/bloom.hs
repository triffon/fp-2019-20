import BinaryTree (BinaryTree(Empty, Node))

bloom :: BinaryTree t -> BinaryTree t
bloom Empty = Empty
bloom t@(Node x Empty Empty) = Node x t t
bloom (Node x l r) = Node x (bloom l) (bloom r)
