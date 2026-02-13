uncons :: [a] -> Maybe (a, [a])
uncons [] = Nothing
uncons (a:as) = Just(a, as)

stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefix [] ys = Just ys
stripPrefix (x:xs) (y:ys) |x == y = stripPrefix xs ys
stripPrefix _ _ = Nothing

lookup :: Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup k ((x,y):xys)   | k == x = Just y
                        | otherwise = Main.lookup k xys
