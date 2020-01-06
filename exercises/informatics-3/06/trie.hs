data Trie = Node [Edge]

type Edge = (Char, Trie)
type Indent = String

dicToTrie :: [String] -> Trie
dicToTrie = foldr addToTrie (Node [])

addToTrie :: String -> Trie -> Trie
addToTrie "" t = t
addToTrie (a:suffix) (Node edges) = Node (map (addToEdge a suffix) (addEdge a edges))

addToEdge :: Char -> String -> Edge -> Edge
addToEdge a suffix (b, t)
    | a == b    = (a, addToTrie suffix t)
    | otherwise = (b, t)

addEdge :: Char -> [Edge] -> [Edge]
addEdge a edges
    | any (\(b, t) -> a == b) edges = edges
    | otherwise                     = (a, Node []):edges

-- printing

instance Show Trie where
    show = showTrie

showTrie :: Trie -> String
showTrie = concat . (map (++ "\n")) . showTrieLines

showTrieLines :: Trie -> [String]
showTrieLines (Node edges) = concat $ map showEdgeLines edges

showEdgeLines :: Edge -> [String]
showEdgeLines (a, t) = showEdgeWithSuffix a (showTrieLines t)

showEdgeWithSuffix :: Char -> [String] -> [String]
showEdgeWithSuffix a [] = ["-" ++ [a]]
showEdgeWithSuffix a (x:xs) = ("-" ++ [a] ++ "-" ++ x) : (map (("  "++) . slash) xs)

slash :: String -> String
slash "" = ""
slash ('-':ss) = "\\-" ++ ss
slash s = ' ':s

-- demo

myTrie :: Trie
myTrie = dicToTrie ["foo", "bar", "baz", "вход", "извод", "изход"]

main = putStr $ show myTrie

-- todo:

-- test whether trie matches a word
-- inTrie :: Trie -> String -> Bool

-- print all words
-- walk :: Trie -> [String]

-- trieUnion :: Trie -> Trie -> Trie

-- trieIntersection :: Trie -> Trie -> Trie
