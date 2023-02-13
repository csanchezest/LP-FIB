main :: IO ()
main = return ()

-- 1

s2i :: String -> Int
s2i x = (read x) :: Int

operate :: [Int] -> String -> [Int]
operate xs op 
    | op == "+" = ys ++ [a + b]
    | op == "-" = ys ++ [b - a]
    | op == "*" = ys ++ [a * b]
    | otherwise = ys ++ [div b a]
    where
        a = last xs
        b = last $ init xs
        ys = init $ init xs

evalAux :: [Int] -> [String] -> Int
evalAux [x] [] = x
evalAux xs (y:ys) 
    | (y == "*" || y == "+" || y == "-" || y == "/") = evalAux (operate xs y) ys
    | otherwise = evalAux (xs ++ [s2i y]) ys 

eval1 :: String -> Int
eval1 expr = evalAux [] $ words expr

-- 2

check :: [Int] -> String -> [Int]
check xs y 
    | (y == "*" || y == "+" || y == "-" || y == "/") = operate xs y
    | otherwise = xs ++ [s2i y]

eval2 :: String -> Int
eval2 expr = res!!0 
    where res = foldl (\a b -> check a b) [] (words expr)
          
-- 3

fsmap :: a -> [a -> a] -> a
fsmap x fx = foldl (\a b -> b a) x fx

-- 4

quickSort :: [Int] -> [Int] 
quickSort = divideNconquer base divide conquer 
    where
        base [] = Just []
        base [z] = Just [z]
        base _ = Nothing
        divide (x:xs) = (menors, majors)
            where menors = filter (<= x) xs
                  majors = filter (>  x) xs
        conquer (x:_) _ (y1,y2) = y1 ++ [x] ++ y2

divideNconquer :: (a -> Maybe b) -> (a -> (a, a)) -> (a -> (a, a) -> (b, b) -> b) -> a -> b
divideNconquer base divide conquer x = 
    case z of
         Nothing -> conquer x (x1,x2) (y1,y2) 
         Just t -> t
    where
        z = base x
        (x1, x2) = divide x
        y1 = divideNconquer base divide conquer x1
        y2 = divideNconquer base divide conquer x2

--trivial
--base :: (a -> Maybe b)

--directe
--x :: a

--dividir
--divide :: (a -> (a, a))

--vencer
--conquer :: (a -> (a, a) -> (b, b) -> b)

-- 5 

data Racional = Racional Integer Integer
--     deriving (Show)
--     deriving (Show, Eq)

racional :: Integer -> Integer -> Racional
racional x y = Racional x y

numerador :: Racional -> Integer
numerador (Racional x y) = div x $ gcd x y

denominador :: Racional -> Integer
denominador (Racional x y) = div y $ gcd x y

instance Eq Racional where
    (Racional x1 y1) == (Racional x2 y2) = x1 * y2 == x2 * y1
    
instance Show Racional where
    show (Racional x y) = (show $ div x $ gcd x y) ++ "/" ++ (show $ div y $ gcd x y)
    
-- 6

data Tree a = Node a (Tree a) (Tree a)

recXnivells :: Tree a -> [a]
recXnivells t = recXnivells' [t]
    where recXnivells' ((Node x fe fd):ts) = x:recXnivells' (ts ++ [fe, fd])

racionals :: [Racional]
racionals = recXnivells $ arbreRacionals $ Racional 1 1
-- racionals = foldl (\(Racional x y) -> [Racional x y] ++ [Racional x+y y] ++ [Racional x x+y]) (Racional 1 1) $ iterate (+ 0) [1]

arbreRacionals :: Racional -> Tree Racional
arbreRacionals (Racional x y) = Node (Racional x y) fe fd 
    where
        fe = arbreRacionals $ Racional x (x+y)
        fd = arbreRacionals $ Racional (x+y) y
