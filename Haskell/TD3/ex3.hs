unzip :: [(a, b)] -> ([a], [b])
unzip = foldr (\(x, y) (xs, ys) ->(x:xs, y:ys)) ([], [])