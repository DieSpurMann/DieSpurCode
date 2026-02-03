data Vehicles = Velo | Moto | Voiture | Car | Train | Avion

compteTypeVehicule::Vehicles->[Vehicles]->Int
compteTypeVehicule _ [] = 0
compteTypeVehicule v (x:xs)
    | v == x = 1 + compteTypeVehicule v xs
    | otherwise = compteTypeVehicule v xs

compteTypeVehicule2 v vs = length(filter(v==)vs)