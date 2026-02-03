{- HLINT ignore "Use foldr" -}
concat::[[a]] -> [a]
concat [] = []
concat (a:xs) = a ++ Main.concat xs