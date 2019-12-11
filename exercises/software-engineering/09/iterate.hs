iterate' :: (t -> t) -> t -> [t]
iterate' fn x = x : iterate' fn (fn x)
