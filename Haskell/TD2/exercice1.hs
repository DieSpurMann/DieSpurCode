data Ordering = LT | EQ | GT
compare :: Ord a => a -> a -> Main.Ordering
compare a b 
        | a == b = Main.EQ
        | a > b = Main.GT
        | a < b = Main.LT

data Tree a = Leaf a | Node (Tree a) a (Tree a)

occurs :: Ord a => a -> Tree a -> Bool
occurs val (Leaf x) = case Main.compare val x of
    Main.EQ -> True              
    Main.LT -> False   
    Main.GT -> False  
occurs val (Node left root right) = case Main.compare val root of
    Main.EQ -> True              
    Main.LT -> occurs val left   
    Main.GT -> occurs val right  