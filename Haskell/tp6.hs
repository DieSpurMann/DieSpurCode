import System.OsPath (toChar)
import Text.XHtml
data Op = Add | Sub | Mul | Div
    deriving (Eq)

instance Show Op where
    show :: Op -> String
    show Add = "+"
    show Sub = "-"
    show Mul = "x"
    show Div = "/"

valid :: Op -> Int -> Int -> Bool
valid Mul _ _ = True
valid Add _ _ = True
valid Sub a b = a > b
valid Div a b =  a `mod` b == 0

apply :: Op -> Int -> Int -> Int
apply Div a b = a `div` b
apply Add a b = a + b
apply Mul a b = a * b
apply Sub a b = a - b

data Expr = Val Int | App Op Expr Expr
    deriving (Eq)

instance Show Expr where
    show :: Expr -> String
    show (Val n) = show n
    show (App op e1 e2) = parenthesize e1 ++ show op ++ parenthesize e2
      where
        parenthesize (Val n) = show n
        parenthesize e       = "(" ++ show e ++ ")"

values :: Expr -> [Int]
values (Val n) = [n]
values (App _ e1 e2) = values e1 ++ values e2

eval :: Expr -> [Int]
eval (Val n) = [n | n > 0]
eval (App op e1 e2) = [apply op x y | x <- eval e1, y <- eval e2, valid op x y]

interleave :: a -> [a] -> [[a]]
interleave x []     = [[x]]
interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)

perms :: [a] -> [[a]]
perms [] = [[]]
perms (x:xs) = concat [interleave x ys | ys <- perms xs]

subs :: [a] -> [[a]]
subs [] = [[]]
subs (x:xs) = map (x:) (subs xs) ++ subs xs

choices :: [a] -> [[a]]
choices xs = [p | ys <- subs xs, p <- perms ys]

solution :: Expr -> [Int] -> Int -> Bool
solution e ns n = elem (values e) (choices ns) && eval e == [n]

split :: [a] -> [([a], [a])]
split xs = [splitAt i xs | i <- [1..length xs - 1]]

ops :: [Op]
ops = [Add, Sub, Mul, Div]

combine :: Expr -> Expr -> [Expr]
combine l r = [App op l r | op <- ops]

exprs :: [Int] -> [Expr]
exprs []  = []
exprs [n] = [Val n]
exprs ns  = [e | (ls, rs) <- split ns
               , l <- exprs ls        
               , r <- exprs rs
               , e <- combine l r]

solutions :: [Int] -> Int -> [Expr]
solutions ns n = [e | ns' <- choices ns
                    , e   <- exprs ns'
                    , eval e == [n]]

-- Fonction pour afficher proprement [cite: 126]
printSol :: [Expr] -> IO ()
printSol [] = return ()
printSol (x:xs) = do 
    print x
    printSol xs

-- Point d'entrée du programme [cite: 130]
main :: IO ()
main = printSol $ solutions [1,2,3,4,5,6,7,8,9,10,12,24,31,35,72,75,81,89,93,94,96,121,812] 10128