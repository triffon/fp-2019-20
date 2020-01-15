module Main where

import Control.Monad

main :: IO ()
-- main = putStrLn "Hello, world!"
-- String -> IO ()   IO String
-- !!! main = putStrLn ("Въведохте: " ++ getLine)

{-
main = do line <- getLine
          let prompt = "Въведохте: "
          putStrLn $ prompt ++ line
-}

{-
main = do putStrLn "Моля, въведете палиндром: "
          line <- getLine
          let revLine = reverse line
          if revLine == line then putStrLn "Благодаря!"
          else do putStrLn $ line ++ " не е палиндром!"
                  main
-}

getInt :: IO Int
getInt = do line <- getLine
            return $ read line


findAverage :: IO Double
findAverage = do putStr "Моля, въведете брой: "
                 n <- getInt
                 s <- readAndSum n
                 return $ fromIntegral s / fromIntegral n

readAndSum :: Int -> IO Int
readAndSum 0 = return 0
readAndSum n = do putStr "Моля, въведете число: "
                  x <- getInt
                  s <- readAndSum (n-1)
                  return (x+s)

{-
main = do avg <- findAverage
          putStrLn $ "Средното аритметично е " ++ show avg
-}

printRead s = do putStr $ s ++ " = "; getInt

readCoordinates = mapM printRead ["x", "y", "z"]

readCoordinatesSecret = do l <- readCoordinates
                           return ()
                           
printList :: [Int] -> IO ()
printList = mapM_ print

{-
f :: a -> b
f x = "anc"
-}

readInt :: String -> IO Int
readInt s = do putStr $ "Моля, въведете " ++ s ++ ": "
               getInt

findAverage2 :: IO Double
findAverage2 = do
  n <- readInt "брой"
  l <- mapM (readInt.("число #"++).show) [1..n]
  let s = sum l
  return $ fromIntegral s / fromIntegral n

main = forever $
       do avg <- findAverage2
          putStrLn $ "Средното аритметично е: " ++ show avg
          putStrLn "Хайде отново!"

noSpaces = do text <- getContents
              putStr $ filter (/=' ') text

noSpaces2 = do c <- getChar
               if c /= ' ' then putChar c else return ()
               noSpaces2
               
