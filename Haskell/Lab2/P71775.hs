main :: IO ()
main = return ()

countIf :: (Int -> Bool) -> [Int] -> Int
countIf f x = sum $ map (const 1) $ foldr (\a b -> if (f a) then a:b else b) [] x

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam x y = map (\f -> map f x) y

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 x y = map (\a -> map (\f -> f a) y) x
--foldl (\b f -> f b) a y

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl f g x y = foldl (g) x $ filter (f) y
--foldl (\a b -> if ((g . f) a b) then (f a b)) x y

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert f x y = takeWhile (\a -> f a y) x ++ [y] ++ dropWhile (\a -> f a y) x

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int] 
insertionSort f x = foldl (\a b -> insert f a b) [] x
