data Entité a = Humain a | Animal a | Végétal a | Minéral
    deriving (Show, Read)

instance Functor Entité where
    fmap f (Humain x) = Humain (f x)
    fmap f (Animal x) = Animal (f x)
    fmap f (Végétal x) = Végétal (f x)
    fmap _ Minéral = Minéral