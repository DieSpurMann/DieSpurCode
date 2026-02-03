splitAt :: Int -> [a] -> ([a], [a])
splitAt x as = (take x as, drop x as)