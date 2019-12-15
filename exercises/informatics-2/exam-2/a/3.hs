-- Задача 3. (8 т.) Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).
-- Да се реализира функция, която по даден списък от покупки връща списък от тройки, съдържащи категория, обща цена на покупките в тази категория и името на магазина, в който общата цена на покупките в тази категория е максимална.
-- Всяка категория да се среща в точно една тройка от резултата.

(|>) :: a -> (a -> b) -> b
x |> f = f x

maxBy :: Ord b => (a -> b) -> [a] -> a
maxBy _ [] = error "Nothing to compare"
maxBy f (h:t) = snd $ foldl comparator (f h, h) t
  where comparator (maxValue, maxX) x
          | value < maxValue = (value, x)
          | otherwise        = (maxValue, maxX)
            where value = f x

unique :: Eq a => [a] -> [a]
unique = reverse . foldl keepOnce []
  where keepOnce seen x
          | x `elem` seen = seen
          | otherwise     = x : seen

type Store = String
type Category = String
type Price = Double
type Purchase = (Store, Category, Price)

getStore :: Purchase -> Store
getStore (_, store, _) = store

getCategory :: Purchase -> Category
getCategory (category, _, _) = category

getPrice :: Purchase -> Price
getPrice (_, _, price) = price

mostExpensive :: [Purchase] -> [(Category, Price, Store)]
mostExpensive purchases = [(
    category,
    getTotalPrice ((== category) . getCategory),
    mostExpensiveStore category
  ) | category <- categories]
  where categories = purchases |> map getCategory |> unique
        getTotalPrice p = purchases |> filter p |> map getPrice |> sum
        mostExpensiveStore category = maxBy (totalPriceFor category) stores
          where stores = purchases |> map getStore |> unique
                totalPriceFor category store = getTotalPrice (\(c, s, _) -> c == category && s == store)

main :: IO ()
main = print ":)"
