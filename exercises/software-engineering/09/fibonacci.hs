-- Поражда дървовиден рекурсивен процес - O(fibonacci n) събирания.
fibonacci :: Int -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 2) + fibonacci (n - 1)

-- Поражда линеен итеративен процес - O(n) събирания.
fibonacci' :: Int -> Integer
fibonacci' n = iter 0 1 n
  where iter a b 0 = a
        iter a b n = iter b (a + b) (pred n)

-- безкраен списък от числата на Фибоначи
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- Взимаме n-тото число от безкрайния списък от числата на Фибоначи.
-- O(n) събирания
fibonacci'' :: Int -> Integer
fibonacci'' = (fibs!!)
