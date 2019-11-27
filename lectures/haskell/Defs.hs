module Defs where

fact n
 | n == 0 = 1
 | n >  0 = n * fact (n - 1)
 | n < 0  = error "Отрицателен аргумент!"

x = 2

area x1 y1 x2 y2 x3 y3 =
   let  a = dist x1 y1 x2 y2
        b = dist x2 y2 x3 y3
        c = dist x3 y3 x1 y1
        p = (a + b + c) / 2
   in sqrt (p * (p - a) * (p - b) * (p - c))
   where dist u1 v1 u2 v2 = sqrt (du^2 + dv^2)
          where du = u2 - u1
                dv = v2 - v1

-- x = 5
