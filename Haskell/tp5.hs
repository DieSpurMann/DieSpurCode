import System.IO
import Control.Monad.RWS.Class (MonadState(put))


getCh:: IO Char
getCh = do
    hSetEcho stdin False
    c <- getChar
    hSetEcho stdin True
    return c

sgetLine :: IO String
sgetLine = do
    c <- getCh
    if c == '\n' then
        do
            putChar c
            return  ""
    else do
        putChar '-'
        cs <- sgetLine
        return (c:cs)

match :: String -> String -> String
match secret guess = [if s `elem` guess then s else '-' | s <- secret]

play :: String -> IO ()
play answer =  do
    putStrLn "Guess the word:"
    guess <- sgetLine
    if guess == answer then
        putStrLn "You win!"
    else do
        putStrLn $ match answer guess
        play answer

hangman :: IO ()
hangman = do
    putStrLn "Welcome to Hangman!"
    putStrLn "Enter the secret word:"
    secret <- sgetLine
    putStrLn "Let the game begin!"
    play secret

main :: IO ()
main = hangman

type Matf = Int -> Int -> (Bool, Int)

exemple :: Matf
exemple i j
    | i >= 1 && i <= 6 && j >= 1 && j <= 5 = (True, i + j + 1)
    | otherwise                            = (False, 0)

identite4x4 :: Matf
identite4x4 i j
    | i < 1 || i > 4 || j < 1 || j > 4 = (False, 0)
    | i == j                           = (True, 1)
    | otherwise                        = (True, 0)

nbLines :: Matf -> Int
nbLines m = iter 1
  where iter i = if fst (m i 1) then iter (i + 1) else i - 1

nbCols :: Matf -> Int
nbCols m = iter 1
  where iter j = if fst (m 1 j) then iter (j + 1) else j - 1

dims :: Matf -> (Int, Int)
dims m = (nbLines m, nbCols m)

cmpDims :: Matf -> Matf -> Bool
cmpDims m1 m2 = dims m1 == dims m2


add :: Matf -> Matf -> Matf
add m1 m2
    | not (cmpDims m1 m2) = error "add appliquée à 2 matrices de tailles différentes"
    | otherwise = \i j ->
        let (valide1, v1) = m1 i j
            (valide2, v2) = m2 i j
        in if valide1 && valide2 
           then (True, v1 + v2) 
           else (False, 0)

identite6x5 :: Matf
identite6x5 i j
    | i >= 1 && i <= 6 && j >= 1 && j <= 5 = (True, if i == j then 1 else 0)
    | otherwise                            = (False, 0)


-- words "10 4 3 + 2 * -" Donne : ["10", "4", "3", "+", "2", "*", "-"] En gros c'est un split

evalElem :: (Num a, Read a) => [a] -> String -> [a]
evalElem (y:x:xs) "+" = (x + y) : xs
evalElem (y:x:xs) "-" = (x - y) : xs
evalElem (y:x:xs) "*" = (x * y) : xs
evalElem stack numStr = read numStr : stack

evalNPI :: (Num a, Read a) => String -> a
evalNPI expr = head (foldl evalElem [] (words expr))

evalNPI' :: (Num a, Read a) => String -> a
evalNPI' = head . foldl evalElem [] . words