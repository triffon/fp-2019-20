module BST
  (BST, root, left, right, isEmpty, bstInsert, bstSearch,
  bstSize, bstFromList, bstToList, bstSort, bstPath) where

import BinaryTree (BinaryTree(Empty, Node), root, left, right, isEmpty)

type BST = BinaryTree

bstInsert :: Ord t => BST t -> t -> BST t
bstInsert Empty x = Node x Empty Empty
bstInsert t@(Node x l r) x'
  | x' < x    = Node x (bstInsert l x') r
  | x' > x    = Node x l (bstInsert r x')
  | otherwise = t

bstSearch :: Ord t => BST t -> t -> Bool
bstSearch Empty _ = False
bstSearch (Node x l r) x'
  | x' == x   = True
  | x' < x    = bstSearch l x'
  | otherwise = bstSearch r x'

bstSize :: BST t -> Int
bstSize Empty = 0
bstSize (Node _ l r) = 1 + bstSize l + bstSize r

bstFromList :: Ord t => [t] -> BST t
bstFromList = foldl bstInsert Empty

bstToList :: BST t -> [t]
bstToList Empty = []
bstToList (Node x l r) = bstToList l ++ x : bstToList r

bstSort :: Ord t => [t] -> [t]
bstSort = bstToList . bstFromList

data Direction = L | R deriving Show

bstPath :: Ord t => BST t -> t -> Maybe [Direction]
bstPath Empty _ = Nothing
bstPath (Node x l r) x'
  | x' == x    = Just []
  | x' < x     = fmap (L :) (bstPath l x')
  | otherwise  = fmap (R :) (bstPath r x')
