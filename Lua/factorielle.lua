function factorielle(N)
    i = N
    res = N
    while i > 2 do
        i = i - 1
        res = res * i
    end
    return res
end

print(factorielle(6))