not::Bool -> Bool
not True = False
not False = True

and::[Bool] -> Bool
and [b] = b
and (b:bs) = b && Main.and bs

or::[Bool] -> Bool
or [b] = b
or (b:bs) = b || Main.or bs