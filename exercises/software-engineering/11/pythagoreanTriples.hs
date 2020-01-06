pythagoreanTriples :: [(Int, Int, Int)]
pythagoreanTriples = [(a, b, c) | c <- [1..998],
                                  b <- [1..(999 - c)],
                                  let a = 1000 - b - c,
                                  a^2 + b^2 == c^2]

pythagoreanTriplesCount :: Int
pythagoreanTriplesCount = length pythagoreanTriples
