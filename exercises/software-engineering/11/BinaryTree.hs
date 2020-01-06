module BinaryTree (BinaryTree(Empty, Node), root, left, right, isEmpty) where

data BinaryTree t = Empty | Node { root :: t,
                                   left :: BinaryTree t,
                                   right :: BinaryTree t }
                    deriving (Eq, Ord, Show, Read)

isEmpty :: BinaryTree t -> Bool
isEmpty Empty = True
isEmpty _ = False
