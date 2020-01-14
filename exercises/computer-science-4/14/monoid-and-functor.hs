{-# LANGUAGE InstanceSigs #-}   -- can write signatures in instance declarations
{-# LANGUAGE KindSignatures #-} -- can write kind signatures

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}     -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}          -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}      -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}          -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- warn about incomplete patterns v2

import Prelude hiding (Maybe(..), Semigroup(..), Monoid(..), Functor(..))


-- Последно се занимавахме с Maybe и BTree
data Maybe a
  = Nothing
  | Just a
  deriving Show

-- Нещо, което би ни се наложило да правим с Maybe
-- би било да поменим стойността му
-- За да не правим разглеждане на случаи всеки път с case,
-- нека си напишем функция и си спестим писане.
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing
mapMaybe f (Just x) = Just $ f x

-- Тази дефиниция ни изглежда позната
-- За списъци изглеждаше така:
-- map :: (a -> b) -> [a] -> [b]

-- За дървета също писахме нещо подобно
data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show
-- mapTree :: (a -> b) -> Tree a -> Tree b
-- Не може ли да генерализираме такива неща?
-- (които могат да се map-ват)

-- Вече се сблъскахме с Eq и Ord,
-- където искахме представителите на даден тип
-- да поддържат дадена операция.
-- В случея обаче е по-различно,
-- Защото (Tree a) е все едно тип над произволен тип (a).
-- Или по друг начин казано - Tree е типов конструктор.
-- TODO: kinds, типови конструктори
-- TODO: примери

-- TODO: типа на fmap

class Functor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b

-- TODO: Примери за fmap
-- TODO: инфиксен оператор <$> за fmap


-- Също така писахме прости функции за дървета
-- Като такава, която намира сумата на елементите
-- на дърво от числа.
-- Не може ли да е дърво от произволни елементи?
-- Тогава те трябва да поддържат някаква бинарна операция.
class Monoid a where
  mempty :: a
  (<>) :: a -> a -> a -- mappend
-- Методите на моноида както при други класове,
-- трябва да изпълняват определени свойства:
-- mempty е нулев елемент
-- mempty <> x == x == x <> mempty
-- (<>) е асоциативна
-- (x <> y) <> z == x <> (y <> z)
infixr 6 <>

-- TODO: Пример на mempty и (<>) със списъци
-- TODO: Monoid Int?

-- Int като моноид със събиране
newtype Sum = Sum Int
-- newtype е като data, но само с 1 конструктор

getSum :: Sum -> Int
getSum (Sum x) = x

instance Monoid Sum where
  mempty :: Sum
  mempty = Sum 0
  (<>) :: Sum -> Sum -> Sum
  (<>) (Sum x) (Sum y) = Sum (x + y)

-- Int като моноид със умножение
newtype Prod = Prod Int

getProd :: Prod -> Int
getProd (Prod x) = x

instance Monoid Prod where
  mempty :: Prod
  mempty = Prod 1
  (<>) :: Prod -> Prod -> Prod
  (<>) (Prod x) (Prod y) = Prod (x * y)

-- TODO: Either (задачи??)

-- Тук можете да четете за различните типови класове в Haskell
-- https://wiki.haskell.org/Typeclassopedia

-- ЗАДАЧИ
-- TODO^

