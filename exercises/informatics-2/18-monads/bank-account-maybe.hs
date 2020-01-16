import qualified Data.Map as Map

-- 2. bank account - Client/BankAccount/Transactions
-- Find the biggest transaction by amount of the client with most transactions

data Transaction = Transaction { amount :: Double, timestamp :: String } deriving Show

type BankAccount = [Transaction]

data Client = Client { name :: String, accounts :: [BankAccount] } deriving Show

type ClientID = String
type DB = Map.Map ClientID Client

maximumBy :: Ord b => (a -> b) -> [a] -> a
maximumBy f = foldl1 (maxBy f)
  where maxBy f x y
          | f y > f x = y
          | otherwise = x

mostActiveAccount :: Client -> Maybe BankAccount
mostActiveAccount (Client _ []) = Nothing
mostActiveAccount (Client _ accounts) = Just $ maximumBy length accounts

mostExpensiveTransaction :: BankAccount -> Maybe Transaction
mostExpensiveTransaction [] = Nothing
mostExpensiveTransaction account = Just $ maximumBy amount account

mostExpensiveClientTransaction :: DB -> ClientID -> Maybe (Client, Transaction)
mostExpensiveClientTransaction clients clientID =
  case Map.lookup clientID clients of -- Maybe Client
    Nothing -> Nothing
    Just client -> case mostActiveAccount client of -- Maybe Account
      Nothing -> Nothing
      Just account -> case mostExpensiveTransaction account of -- Maybe Transaction
        Nothing -> Nothing
        Just transaction -> Just (client, transaction)

mostExpensiveClientTransaction' :: DB -> ClientID -> Maybe (Client, Transaction)
mostExpensiveClientTransaction' clients clientID =
  Map.lookup clientID clients
  >>= (\ client -> mostActiveAccount client
  >>= (\ account -> mostExpensiveTransaction account
  >>= (\ transaction -> return (client, transaction))))

mostExpensiveClientTransaction'' :: DB -> ClientID -> Maybe (Client, Transaction)
mostExpensiveClientTransaction'' clients clientID = do
  client <- Map.lookup clientID clients
  account <- mostActiveAccount client
  transaction <- mostExpensiveTransaction account
  return (client, transaction)
