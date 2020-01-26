import Map (Map, mapSearch)

data Meal = Meal { title :: String, price :: Double } deriving Show

type Order = [Meal]

data Client = Client { name :: String, orders :: [Order] } deriving Show

maximumBy :: Ord b => (a -> b) -> [a] -> a
maximumBy f = foldl1 (maxBy f)
  where maxBy f x y
          | f y > f x = y
          | otherwise = x

type Error = String

largestClientOrder :: Client -> Either Error Order
largestClientOrder (Client _ []) = Left "Client doesn't have any orders"
largestClientOrder (Client _ orders) = Right $ maximumBy length orders

mostExpensiveOrderMeal :: Order -> Either Error Meal
mostExpensiveOrderMeal [] = Left "Order is empty"
mostExpensiveOrderMeal order = Right $ maximumBy price order

-- mostExpensiveClientMeal :: Map String Client -> String -> Maybe (Client, Meal)
-- mostExpensiveClientMeal clients clientName =
--   case mapSearch clients clientName of -- Maybe Client
--     Nothing -> Nothing
--     Just client -> case largestClientOrder client of -- Maybe Order
--       Nothing -> Nothing
--       Just order -> case mostExpensiveOrderMeal order of
--         Nothing -> Nothing
--         Just meal -> Just (client, meal)

toEither :: Maybe Client -> Either Error Client
toEither Nothing = Left "Client not found"
toEither (Just client) = Right client

mostExpensiveClientMeal' :: Map String Client -> String -> Either Error (Client, Meal)
mostExpensiveClientMeal' clients clientName =
  (toEither $ mapSearch clients clientName)
  >>= (\ client -> largestClientOrder client
                   >>= (\ order -> mostExpensiveOrderMeal order
                                   >>= (\ meal -> return (client, meal))))

mostExpensiveClientMeal'' :: Map String Client -> String -> Either Error (Client, Meal)
mostExpensiveClientMeal'' clients clientName = do
  client <- toEither $ mapSearch clients clientName
  order <- largestClientOrder client
  meal <- mostExpensiveOrderMeal order
  return (client, meal)
