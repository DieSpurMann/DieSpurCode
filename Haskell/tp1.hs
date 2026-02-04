qsort::Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
    where
        smaller = [a | a <- xs, a <= x]
        larger = [a | a <- xs, a > x]

egaux4::Int -> Int -> Int -> Int -> Bool
egaux4 a b c d = (a == b) && (b == c) && (c == d)

max4:: Int -> Int -> Int -> Int -> Int
max4 a b c d = max (max a b) (max c d)

sumcarre:: Int -> Int
sumcarre 0 = 0 
sumcarre x = x^2 + sumcarre(x-1) 

replic:: Ord a => a -> Int -> [a]
replic a 0 = []
replic a x = a : (replic a (x-1))

replicc:: Ord a => a -> Int -> [a]
replicc x n = [x | _ <- [1..n]]

pyths:: Int -> [(Int, Int, Int)]
pyths n = [(j, d, g) | j <- [1..n], d <- [1..n], g <- [1..n], j^2 + d^2 == g^2 || d^2 + g^2 == j^2 || j^2 + g^2 == d^2, j == n || d == n || g == n]

reverse:: [a] -> [a]
reverse [] = []
reverse ls = last ls : Main.reverse (init ls)

isPalindrome:: Eq a => [a] -> Bool
isPalindrome as = as == Main.reverse(as) 

doPalindrome:: [a] -> [a]
doPalindrome as = as ++ Main.reverse(init as)

data Parfum = Chocolat | Vanille | Framboise
    deriving (Show, Eq)

prixParfum:: Parfum -> Float
prixParfum Chocolat = 1.5
prixParfum Vanille = 1.2
prixParfum Framboise = 1.4

data Glace = UneBoule Parfum 
           | DeuxBoules Parfum Parfum 
           | TroisBoules Parfum Parfum Parfum
           deriving (Show, Eq)

prixGlace:: Glace -> Float
prixGlace (UneBoule p1)          = prixParfum p1 + 0.1
prixGlace (DeuxBoules p1 p2)      = sum (map prixParfum [p1, p2]) + 0.15
prixGlace (TroisBoules p1 p2 p3) = sum (map prixParfum [p1, p2, p3]) + 0.2

type Domino = (Int, Int)

dominosA2Match :: Domino -> Domino -> Bool
dominosA2Match (a, b) (c, d) = a == c || a == d || b == c || b == d

dominosA3Match :: Domino -> Domino -> Domino -> Bool
dominosA3Match d1 d2 d3 = dominosA2Match d1 d2 && dominosA2Match d2 d3