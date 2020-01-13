data Trie = Node Finality [Edge]

data Finality = Final | NonFinal
type Edge = (Char, Trie)
type Indent = String

dicToTrie :: [String] -> Trie
dicToTrie = foldr addToTrie (Node NonFinal [])

addToTrie :: String -> Trie -> Trie
addToTrie "" (Node _ edges) = Node Final edges
addToTrie (a:suffix) (Node final edges) = Node final (map (addToEdge a suffix) (addEdge a edges))

addToEdge :: Char -> String -> Edge -> Edge
addToEdge a suffix (b, t)
    | a == b    = (a, addToTrie suffix t)
    | otherwise = (b, t)

addEdge :: Char -> [Edge] -> [Edge]
addEdge a edges
    | any (\(b, t) -> a == b) edges = edges
    | otherwise                     = (a, Node NonFinal []):edges

-- printing

instance Show Trie where
    show = showTrie

showTrie :: Trie -> String
showTrie = concat . (map (++ "\n")) . slashify . showTrieLines

showTrieLines :: Trie -> [String]
showTrieLines (Node    Final    []) = ["-*"]
showTrieLines (Node NonFinal    []) = ["-."]
showTrieLines (Node    Final edges) = concat $ map (showEdgeLines "-*-") edges
showTrieLines (Node NonFinal edges) = concat $ map (showEdgeLines "-.-") edges

showEdgeLines :: String -> Edge -> [String]
showEdgeLines marker (a, t) = showEdgeWithSuffix marker a (showTrieLines t)

showEdgeWithSuffix :: String -> Char -> [String] -> [String]
showEdgeWithSuffix marker a [] = [marker ++ [a]]
showEdgeWithSuffix marker a (x:xs) = (marker ++ [a] ++ "-" ++ x) : (map (("    "++) . slash) xs)

slashify :: [String] -> [String]
slashify [] = []
slashify (s:ss) = s : (map ((""++) . slash) ss)

slash :: String -> String
slash "" = ""
slash ('-':'.':ss) = " \\" ++ ss
slash ('-':'*':ss) = " \\" ++ ss
slash s = ' ':s

-- demo

myTrie :: Trie
myTrie = dicToTrie ["foo", "bar", "baz", "вход", "извод", "изход", "ba"]

main = putStr $ show myTrie

-- todo:

-- test whether trie matches a word
-- inTrie :: Trie -> String -> Bool

-- print all words
-- walk :: Trie -> [String]

-- trieUnion :: Trie -> Trie -> Trie

-- trieIntersection :: Trie -> Trie -> Trie

-- deleteWord :: String -> Trie -> Trie

-- trieDifference :: Trie -> Trie -> Trie
