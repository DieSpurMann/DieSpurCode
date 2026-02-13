import Data.Char (digitToInt)
data Either a b = Left a | Right b

parseEither:: Char -> Main.Either String Int
parseEither c   | isDigit c = Main.Right (digitToInt c)
                | otherwise = Main.Left "parse error"