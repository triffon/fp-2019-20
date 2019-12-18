import Data.Bits ((.&.))

-- Задача 2. (8 т.) Казваме, че две положителни цели числа се “застъпват”, ако в двоичния си запис имат цифра 1 на една и съща позиция отдясно наляво (побитовото им “И” е ненулево). Да се дефинира функция sigert, която генерира безкрайната редица от елементи, дефинирана чрез следната формула за n ≥ 1:
-- an = min { x | ∄k < n ( k и n се застъпват и ak = x ) }
-- Пример: sigert → [ 0, 0, 1, 0, 2, 3, 4, 0, 3, 2, 5, 1, 6, 7, 8, …

overlap :: Int -> Int -> Bool
overlap a b = (a .&. b) > 0

sigert :: [Int]
sigert = generate 1 []
  where generate n seq = nextNumber : generate (n + 1) nextSeq
          where nextNumber = head $ filter isFromSequence [0..]
                nextSeq = seq ++ [nextNumber]
                isFromSequence x = null [k | k <- [0 .. (n - 1)],
                                             overlap k n,
                                             seq !! (k - 1) == x]

main :: IO ()
main = print ":)"