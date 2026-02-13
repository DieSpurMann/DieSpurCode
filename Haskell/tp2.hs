paire :: Int -> Bool
paire 0 = True
paire a = impaire (a-1)

impaire :: Int -> Bool
impaire 0 = False
impaire a = paire (a-1)

insert :: Ord a => a -> [a] -> [a] 
insert x [] = [x]
insert elt (head:xs)    | elt <= head = elt : head : xs
                        | otherwise = head : insert elt xs

isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)

halve :: [a] -> ([a], [a])
halve as = (take(length as `div` 2) as, drop (length as `div` 2) as)

merge :: Ord a => [a] -> [a] -> [a]
merge [] bs = bs
merge as [] = as
merge (a:as) (b:bs) 
    | a <= b = a : merge as (b:bs)
    | otherwise = b : merge (a:as) bs

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort as = merge (msort(fst(halve as))) (msort(snd(halve as))) 

data Prop = Const Bool
    | Var Char
    | Not Prop
    | And Prop Prop
    | Imply Prop Prop

type Assoc k v = [(k, v)]
type Subst = Assoc Char Bool 

find :: Eq k => k -> Assoc k v -> v
find k ((key, val):xs)
    | k == key  = val
    | otherwise = find k xs

eval :: Subst -> Prop -> Bool
eval _ (Const b) = b
eval s (Var x) = find x s
eval s (Not p) = not (eval s p)
eval s (And p q) = eval s p && eval s q
eval s (Imply p q) = not (eval s p) || eval s q

vars2 :: Prop -> [Char]
vars2 (Const _) = []
vars2 (Var x) = [x]
vars2 (Not p) = vars2 p
vars2 (And p q) = vars2 p ++ vars2 q
vars2 (Imply p q) = vars2 p ++ vars2 q

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = [ b:bs | b <- [False, True], bs <- bools (n-1) ]

substs :: Prop -> [Subst]
substs p = map (zip vs) (bools (length vs))
    where vs = vars2 p

isTaut :: Prop -> Bool
isTaut p = and [eval s p | s <- substs p]

p1 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))
p2 :: Prop
p2 = Imply (And (Var 'A') (Var 'B')) (Var 'A')
p3 :: Prop
p3 = Imply (Var 'A') (And (Var 'A') (Var 'B'))
p4 :: Prop
p4 = Imply (And (Var 'A') (Imply (Var 'A') (Var 'B'))) (Var 'B')