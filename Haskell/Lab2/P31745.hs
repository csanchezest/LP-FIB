main :: IO ()
main = return ()

flatten :: [[Int]] -> [Int]
flatten x = foldl (++) [] x

myLength :: String -> Int 
myLength x = sum $ map (const 1) x

myReverse :: [Int] -> [Int]
myReverse y = foldl (\xs x -> x:xs) [] y

countIn :: [[Int]] -> Int -> [Int]
countIn xs y = map (\x -> foldl (+) 0 $ map (const 1) (filter (==y) x)) xs

firstWord :: String -> String
firstWord xs = takeWhile (/= ' ') $ dropWhile (==' ') xs
