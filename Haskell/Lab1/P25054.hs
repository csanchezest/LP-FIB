main :: IO ()
main = return ()

myLength :: [Int] -> Int 
myLength [] = 0
myLength (_:x) = 1 + myLength x

myMaximum :: [Int] -> Int
myMaximum [x] = x
myMaximum (x:xs)
    | (maximum xs) > x = maximum xs
    | otherwise = x
    --4 5 7 8
suma :: [Int] -> Int
suma xs = sum xs
--suma [x] = x
--suma (x:xs) = x + suma xs

average :: [Int] -> Float 
average (x:xs) = (fromIntegral (x + suma xs)) / (fromIntegral (1 + myLength xs)) 

buildPalindrome :: [Int] -> [Int] 
buildPalindrome xs = (reverse xs) ++ xs
--buildPalindrome [x] = [x] ++ [x]
--buildPalindrome (x:xs) = [x] ++ buildPalindrome xs ++ [x]

remove :: [Int] -> [Int] -> [Int]
remove [] y = []
remove (x:xs) y 
    | x `elem` y = remove xs y
    | otherwise = [x] ++ remove xs y

flatten :: [[Int]] -> [Int] 
flatten [] = []
flatten (x:xs) = x ++ flatten xs

oddsNevens :: [Int] -> ([Int],[Int]) 
oddsNevens xs = (filter odd xs,filter even xs)

isPrime :: Int -> Bool
isPrime n = if n > 1 then null [ x | x <- [2.. n - 1], n `mod` x == 0] else False

primeDivisors :: Int -> [Int] 
primeDivisors n = [x | x <- [2 .. n], isPrime x && n `mod` x == 0]

