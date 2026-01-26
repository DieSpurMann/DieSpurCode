
fibonacci :: Int -> Int
fibonacci n
    | n <= 0    = 0
    | n == 1   = 1
    | otherwise = fibonacci (n - 1) + fibonacci (n - 2)

fibFast :: Int -> Integer
fibFast n = help n 0 1
  where
    help 0 a b = a
    help n a b = help (n - 1) b (a + b) -- We pass the results to the next call

fibolist :: [Integer]
fibolist = [fibFast n | n <- [1..]]

main :: IO () 
main = do
    print (take 1000 fibolist)