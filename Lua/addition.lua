function addition(n1, n2)
    local result = n1 + n2
    return result
end


print("Entrez le nombre d'addition que vous voulez faire.\n")
times = io.read("*n")
for i = 1, times,1 do
    print("Entrez le premier terme")
    x = io.read("*n")
    print("Entrez le second terme")
    y = io.read("*n")
    print("Le resultat de l'addition", x,"+", y,"est egal a", addition(x, y), "\n")
end