third :: [a] -> a
-- third xs = head(tail(tail(xs)))
third = head.tail.tail

replicate :: Int -> a -> [a]
-- replicate n x = take n (repeat x)
replicate n = take n.repeat