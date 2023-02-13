main :: IO ()
main = return ()

absValue :: Int -> Int
absValue x = abs x

power :: Int -> Int -> Int
power x p = x ^ p

isPrime :: Int -> Bool
isPrime n = if n > 1 then null [ x | x <- [2.. n - 1], n `mod` x == 0] else False
        

slowFib :: Int -> Int
slowFib n
     | n == 0       = 0
     | n == 1       = 1
     | otherwise    = slowFib (n-1) + slowFib (n-2)

quickFib :: Int -> Int
quickFib n = fibs!!n
    where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
