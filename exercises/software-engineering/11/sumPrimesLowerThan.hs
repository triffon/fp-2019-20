primes :: Integral t => [t]
primes = sieve [2..]
  where sieve (x:xs) = x : sieve [y | y <- xs, y `mod` x > 0]

primesLowerThan :: Integral t => t -> [t]
primesLowerThan n = takeWhile (< n) primes

sumPrimesLowerThan :: Integral t => t -> t
sumPrimesLowerThan = sum . primesLowerThan
