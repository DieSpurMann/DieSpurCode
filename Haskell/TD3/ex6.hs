class Functor t => Applicative t where
    pure :: a -> t a
    (<*>) :: t (a -> b) -> t a -> t b

data Entité a = Humain a | Animal a | Végétal a | Minéral
    deriving (Show, Read)

instance Main.Applicative Entité where
    pure = Humain
    (Humain f) <*> e = fmap f e
    Animal f <*> e = fmap f e
    Végétal f <*> e = fmap f e
    Minéral <*> e = e