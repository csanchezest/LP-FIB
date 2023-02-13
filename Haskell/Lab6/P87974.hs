resposta nom
    | final == 'a' = "Hola maca!"
    | final == 'A' = "Hola maca!"
    | otherwise = "Hola maco!"
    where final = head $ reverse nom

main = do
    nom <- getLine
    putStrLn $ resposta nom
