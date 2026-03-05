import Data.Char
import Data.Bits (Bits(rotate))


let2int :: Char -> Int
let2int c = ord c - ord 'A'  -- On utilise 'A' au lieu de 'a'

int2let :: Int -> Char
int2let n = chr (ord 'A' + n) -- Pareil ici

freqs :: String -> [Float]
freqs xs = [percent (count c xs) n | c <- ['A'..'Z']] -- On compte de 'A' à 'Z'
    where n = length xs

shift :: Int -> Char -> Char
shift x c = int2let ((let2int c + x) `mod` 26)

cypherrec :: Int -> String -> String
cypherrec x [] = []
cypherrec x (c:cs) = shift x c : cypherrec x cs

cyphercomp :: Int -> String -> String
cyphercomp x xs = [shift x c | c <- cleanstr xs]

cyphermap :: Int -> String -> String
cyphermap x = map (shift x)

percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100

count :: Char -> String -> Int
count c xs = length [x | x <- xs, x == c]

chisqrrec :: [Float] -> [Float] -> Float
chisqrrec [] [] = 0
chisqrrec (o:os) (e:es) = ((o - e) ^ 2) / e + chisqrrec os es

chisqrcomp :: [Float] -> [Float] -> Float
chisqrcomp os es = sum [ if e == 0 then o else ((o - e) ^ 2) / e | (o, e) <- zip os es]

rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

rotaterec :: Int -> [a] -> [a]
rotaterec _ [] = []
rotaterec n xs | n <= 0 = xs
rotaterec n (x:xs) = rotaterec (n - 1) (xs ++ [x])

positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..], x == x']


crack :: String -> String
crack xs = cyphercomp (-factor) xs
  where 
    factor = head (positions (minimum chitab) chitab)
    chitab = [chisqrcomp (Main.rotate n table') table' | n <- [0..25]]
    table' = freqs xs

cleanstr :: String -> String
cleanstr xs = [toUpper c | c <- xs, isAlpha c]

tableFr :: [Float]
tableFr = [7.63, 0.90, 3.26, 3.67, 14.71, 1.06, 0.86, 0.73, 7.52, 0.61, 
           0.04, 5.45, 2.96, 7.09, 5.79, 2.52, 1.36, 6.69, 7.94, 7.24, 
           6.31, 1.83, 0.04, 0.42, 0.12, 0.03]

tableEn :: [Float]
tableEn = [8.16, 1.49, 2.78, 4.25, 12.70, 2.22, 2.01, 6.09, 6.96, 0.15, 
           0.77, 4.02, 2.40, 6.74, 7.50, 1.92, 0.09, 5.98, 6.32, 9.05, 
           2.75, 0.97, 2.36, 0.15, 1.97, 0.07]

crackengfra :: String -> String
crackengfra xs = cyphercomp (-factor) xs
  where
    table' = freqs xs
    chitabFr = [chisqrcomp (Main.rotate n table') tableFr | n <- [0..25]]
    chitabEn = [chisqrcomp (Main.rotate n table') tableEn | n <- [0..25]]
    minFr = minimum chitabFr
    minEn = minimum chitabEn
    factor = if minFr < minEn
        then head (positions minFr chitabFr)
        else head (positions minEn chitabEn)