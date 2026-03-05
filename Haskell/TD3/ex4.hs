hello :: IO()
hello = do  putStrLn "Hello"
            putStr "What is your name?"
            name <- getLine
            if null name 
                then return ()
                else putStrLn ("Hello " ++ name ++ "!")
