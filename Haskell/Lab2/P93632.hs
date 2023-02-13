main :: IO ()
main = return ()

equ :: Int -> Int -> Bool
equ x y = x == y

eql :: [Int] -> [Int] -> Bool
eql x y = all (==True) (zipWith (==) x y) && length x == length y
--eql x y = all (==True) (zipWith (equ) x y) && length x == length y

prod :: [Int] -> Int
prod x = foldl (*) 1 x

prodOfEvens :: [Int] -> Int
prodOfEvens x = foldl (*) 1 (filter even x)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float 
scalarProduct x y = sum (zipWith (*) x y)
