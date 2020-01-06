divides :: Integral t => t -> t -> Bool
divisor `divides` dividend = dividend `mod` divisor == 0

divisibleByEvery :: Integral t => t -> [t] -> Bool
dividend `divisibleByEvery` divisors = all (`divides` dividend) divisors

smallestMultiple :: Integral t => t -> t
smallestMultiple n = head [x | x <- [n..], x `divisibleByEvery` [1..n]]
