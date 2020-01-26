module Map
  (Map, root, left, right, isEmpty, mapInsert, mapSearch) where

import BinaryTree (BinaryTree(Empty, Node), root, left, right, isEmpty)

type Map k v = BinaryTree (k, v)

mapInsert :: Ord k => Map k v -> k -> v -> Map k v
mapInsert Empty k v = Node (k, v) Empty Empty
mapInsert (Node (k, v) l r) k' v'
  | k' < k    = Node (k, v) (mapInsert l k' v') r
  | k' > k    = Node (k, v) l (mapInsert r k' v')
  | otherwise = Node (k, v') l r

mapSearch :: Ord k => Map k v -> k -> Maybe v
mapSearch Empty _ = Nothing
mapSearch (Node (k, v) l r) k'
  | k' == k   = Just v
  | k' < k    = mapSearch l k'
  | otherwise = mapSearch r k'
