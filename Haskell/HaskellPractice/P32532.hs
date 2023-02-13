main :: IO ()
main = return ()

-- 1

divisors :: Int -> [Int] 
divisors x = [y | y <- [1..x], mod x y == 0]

-- 2

nbDivisors :: Int -> Int
nbDivisors x = length $ divisors x

-- 3

moltCompost :: Int -> Bool
moltCompost x = all (< a) $ map (nbDivisors) [y | y <- [t..x-1]] 
    where a = nbDivisors x
          t = div x 2
-- moltCompost x = not $ any (< a) $ map (nbDivisors) [y | y <- [t..x-1]] 
{-moltCompost x = a > b 
    where
        a = nbDivisors x
        t = div x 2
        b = maximum $ map (nbDivisors) [y | y <- [t..x-1]] -}
--         b = foldl (\w t -> if w>t then w else t) 0 $ map (nbDivisors) [y | y <- [t..x-1]] 
