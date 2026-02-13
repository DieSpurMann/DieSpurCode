data Color = Red | Green | Blue
--    deriving (Eq, Main.Show)

instance Eq Color where
    (==) :: Color -> Color -> Bool
    Red == Red = True
    Green == Green = True
    Blue == Blue = True
    _ == _ = False

colorEq :: Color -> Color -> Bool
colorEq Red Red = True
colorEq Green Green = True
colorEq Blue Blue = True
colorEq _ _ = False

-- Inutile as heck
colorEq2 :: Color -> Color -> Bool
colorEq2 coul1 coul2 = coul1 == coul2
-- Useless but cool
colorEq3 :: Color -> Color -> Bool
colorEq3 = (==)
class Show a where
    show :: a -> String

instance Main.Show Color where
    show :: Color -> String
    show Red = "Red"
    show Green = "Green"
    show Blue = "Blue"
