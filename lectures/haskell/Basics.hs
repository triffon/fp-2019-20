module Basics where

x :: Int
y :: Double
z :: String

x = 10000
-- (define x x) --> !!!
y = fromIntegral x ^ 2 + 7.5
-- type coercion
-- A(int); A a = 3;  operator int();  int x = a;
-- !!! y = 5.9
-- z = fromIntegral x + y
z = "Hello"

fact 0 = 1
fact n = n * fact (n - 1)

x1 = 2
-- y1 = x1 ^ 2 + 7.5

div50 :: Int -> Int
div50 x = div 50 x

twice f x = f (f x)

f x y z t = 2

hypothenuse a b = sqrt (a ** 2 + b ** 2)

diag f x = f x x
sqrt2 = diag hypothenuse -- sqrt(2)*x
lastDigit = (`mod` 10)
