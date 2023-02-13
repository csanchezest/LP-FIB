import Data.List

main :: IO ()
main = return ()

-- 1

degree :: Eq a => [(a, a)] -> a -> Int
degree [] _ = 0
degree (x:xs) e = 
    if e == f || e == s 
       then 1 + rest
       else rest 
    where
        f = fst x
        s = snd x
        rest = degree xs e
        
-- 2

degree' :: Eq a => [(a, a)] -> a -> Int
degree' l e = foldl (\a b -> if e == (fst b) || e == (snd b) then a + 1 else a) 0 l

-- 3

neighbors :: Ord a => [(a, a)] -> a -> [a]
neighbors l e = sort $ map (\(x,y) -> if x == e then y else x) $ filter (\b -> e == (fst b) || e == (snd b)) l
