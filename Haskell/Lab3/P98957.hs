--import Data.List

main :: IO ()
main = return ()

ones :: [Integer]
ones = iterate (+0) 1
--ones = [x | x <- [1,1..] ]

nats :: [Integer]
nats = iterate (+1) 0
--nats = [x | x <- [0,1..] ]

ints :: [Integer]
ints = 0 : (concatMap (\x -> [x, -x]) $ iterate (+1) 1)
--ints = 0 : [y | x <- [1,2..], y <- [x,-x] ]

triangulars :: [Integer]
triangulars = scanl (+) 0 $ iterate (+1) 1

factorials :: [Integer]
factorials = scanl (*) 1 $ iterate (+1) 1

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

getPrimes :: [Integer] -> [Integer]
getPrimes (x:xs) = x : getPrimes [y | y <- xs, mod y x > 0]

primes :: [Integer]
primes = getPrimes $  iterate (+1) 2

insert :: [Integer] -> Integer -> [Integer]
insert [] y = [y]
insert (x:xs) y
    | y <= x = [y] ++ [x] ++ xs
    | otherwise = [x] ++ insert xs y

isort :: [Integer] -> [Integer] 
isort [] = []
isort [x] = [x]
isort (x:xs) =
    let y = isort xs
    in insert y x

--no es meu
hammings :: [Integer]
hammings = 1 : map (2*) hammings `merge` map (3*) hammings `merge` map (5*) hammings
  where merge (x:xs) (y:ys)
          | x < y = x : xs `merge` (y:ys)
          | x > y = y : (x:xs) `merge` ys
          | otherwise = x : xs `merge` ys

          
lookNsay :: [Integer]  
lookNsay = map toInteger $ iterate next "1"
    where
        next :: String -> String
        next [] = []
        next x = (convert prefix) ++ (next sufix)
            where
                prefix = (takeWhile (== head x) x)
                sufix = (dropWhile (== head x) x)
                convert s = show (length s) ++ [head s]
        toInteger :: String -> Integer
        toInteger = read

factorial :: Int -> Integer
factorial n = (scanl (*) 1 $ iterate (+1) 1) !! n

tartaglia :: [[Integer]]
tartaglia = map (\n -> map (\k -> 
    let a = (subtract k n)
        b = factorial a 
        c = factorial k
        d = (b * c) 
    in div (factorial n) d) [0..n]) $ iterate (+1) 0
