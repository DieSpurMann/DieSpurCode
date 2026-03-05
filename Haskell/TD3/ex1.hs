map :: (a -> b) -> [a] -> [b]
map f xs = [f x | x <- xs]

maprec :: (a -> b) -> [a] -> [b]
maprec _ [] = []
maprec f (x:xs) = f x : maprec f xs

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [] = []
takeWhile f (x:xs) | f x = x : Main.takeWhile f xs
                   | otherwise = []

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] [] = []
zipWith _ [] _ = []
zipWith _ _ []  = []
zipWith fonc (fst:fsts) (snd:snds) = fonc fst snd : Main.zipWith fonc fsts snds