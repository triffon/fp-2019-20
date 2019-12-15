isProgression :: (Int, Int, Int) -> Bool
isProgression (a, b, c) = c + a == 2 * b

forestFire :: [Int]
forestFire = initialSequence ++ generateFrom 3 initialSequence
  where initialSequence = [1, 1]
        generateFrom n seq = nextNumber : generateFrom (n + 1) nextSeq
          where nextNumber = head $ filter isFromSequence [1, 2 ..]
                nextSeq = seq ++ [nextNumber]
                isFromSequence x = null [k | k <- [1, 2 .. n `div` 2],
                                         let indexA = n - 2 * k - 1,
                                         let indexB = n - k - 1,
                                         inBounds indexA,
                                         inBounds indexB,
                                         isProgression (seq !! indexA, seq !! indexB, x)]
                  where inBounds index = 0 <= index && index < len
                        len = length seq

main :: IO ()
main = print ":)"