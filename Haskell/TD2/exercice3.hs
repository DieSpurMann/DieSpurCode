data Entité = Humain Int | Animal Int | Végétal Int | Minéral

class Vivant a where
    vivant :: a -> Bool

instance Vivant Entité where
    -- vivant :: Entité -> Bool
    vivant Minéral = False
    vivant _ = True

class Vivant a => Comestible a where
    mange :: a -> a -> (a,a)

instance Comestible Entité where
    -- mange: Entité -> Entité --> (Entité, Entité)
    mange x y | not(vivant x) || not(vivant y) = (x, y)
    mange (Végétal e)  y = (Végétal e, y)
    mange (Animal e) (Végétal e2) = (Animal (e+e2), Végétal 0)
    mange (Animal e) (Humain e2) = (Animal e, Humain e2)
    mange (Animal e) (Animal e2) = (Animal e, Animal e2)
    mange (Humain e) (Végétal e2) = (Humain (e + e2), Végétal 0)
    mange (Humain e) (Humain e2) = (Humain e, Humain e2)
    mange (Humain e) (Animal e2)    | e == e2 = (Humain (div e 2), Animal (div e2 2))
                                    | e < e2 = (Humain 0, Animal (e + e2))
                                    | e > e2 = (Humain (e + e2), Animal 0)