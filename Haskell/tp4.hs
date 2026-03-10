import Data.List (replicate, transpose)
import Data.Char (isDigit)

data Player = X | O | B
    deriving (Eq)

instance Show Player where
    show :: Player -> String
    show X = "X"
    show O = "O"
    show B = " "

type Grid = (Int, [[Player]])  

next :: Player -> Player
next X = O
next O = X
next B = B

empty :: Int -> Grid
empty n = (n, replicate n (replicate n B))

full :: Grid -> Bool
full (_, rows) = all (/= B) (concat rows)

diag :: Grid -> [Player]
diag (n, rows) = [rows !! i !! i | i <- [0..( n - 1)]]

wins :: Player -> Grid -> Bool
wins p (n, rows) = any lineIsFull allPossibleLines
  where
    lineIsFull line = all (== p) line
    allPossibleLines = rows 
                    ++ transpose rows 
                    ++ [diag (n, rows)]
                    ++ [diag (n, map reverse rows)]

won :: Grid -> Bool
won g@(n, rows) = wins X g || wins O g

insVert :: [String] -> [String]
insVert (x1:x2:xs) = x1 : "|" : x2 : xs
insVert list = list

showRow :: [Player] -> [String]
showRow [] = []
showRow [p] = [show p] 
showRow (p:ps) = insVert (show p : showRow ps)

insHoriz :: Int -> [String]
insHoriz n = replicate n "---" ++ replicate (n - 1) "-"

showGrid :: Grid -> IO ()
showGrid (_, []) = return ()
showGrid (n, [r]) = putStrLn (concat (showRow r))
showGrid (n, r:rs) = do
    putStrLn (concat (showRow r))
    putStrLn (concat (insHoriz n))
    showGrid (n, rs)

valid :: Grid -> Int -> Bool
valid (n, rows) i = i >= 0 && i < n*n && (flatGrid !! i == B)
  where
    flatGrid = concat rows

cut :: Int -> [a] -> [[a]]
cut _ [] = []
cut n xs = take n xs : cut n (drop n xs)

move :: Grid -> Int -> Player -> [Grid]
move g@(n, rows) i p
    | valid g i = [(n, newRows)]
    | otherwise = []
    where
        flatList = concat rows
        newFlatList = take i flatList ++ [p] ++ drop (i + 1) flatList
        newRows = cut n newFlatList

cls :: IO ()
cls = putStr "\ESC[2J" 

goto :: (Int, Int) -> IO ()
goto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

run :: Grid -> Player -> IO ()
run g p = do cls  
             goto (1,1)
             showGrid g
             run' g p

getNat :: String -> IO Int
getNat message = do putStr message
                    xs <- getLine
                    if xs /= [] && all isDigit xs
                        then return (read xs)
                        else do putStrLn "Error: invalid number"
                                getNat message
tictactoe :: IO ()
tictactoe = do size <- getNat "Entrez la taille de la grille : "
               run (empty size) O

prompt :: Player -> String
prompt p = "Player " ++ show p ++ ", enter your move: " 

run' :: Grid -> Player -> IO ()
run' g p 
    | wins O g   = putStrLn "Player O wins!\n"
    | wins X g   = putStrLn "Player X wins!\n"
    | full g     = putStrLn "It's a draw!\n"
    | otherwise  = do
        i <- getNat (prompt p)
        case move g i p of
            [] -> do 
                putStrLn "Error: invalid move"
                run' g p                 
            [g'] -> run g' (next p)