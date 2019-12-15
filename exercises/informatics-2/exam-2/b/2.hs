-- Задача 2. (8 т.) Разглеждаме безкрайна редица ls от списъци от числа, която започва със списъка [1, 1], а всеки следващ списък се получава от предишния, като между всеки два елемента се вмъкне сумата им. Да се реализира функцията stern, която намира безкраен поток, получен от конкатенацията на списъците в ls с пропуснат последен елемент (който е винаги със стойност 1).
-- Пример: stern → [ 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, ...

intersperseWith :: (a -> a -> a) -> [a] -> [a]
intersperseWith _ [] = []
intersperseWith _ [x] = [x]
intersperseWith comb (a:b:xs) = a : (a `comb` b) : intersperseWith comb (b:xs)

stern :: [Integer]
stern = 1 : generate [1, 1]
  where generate previousList = init nextList ++ generate nextList
          where nextList = intersperseWith (+) previousList

main :: IO ()
main = print ":)"
