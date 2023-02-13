main :: IO ()
main = return ()

-- 1

multEq :: Int -> Int -> [Int] 
multEq x y = scanl (\a b -> a*b) 1 $ repeat $ x*y
-- multEq x y = tail $ scanl (\a b -> a*b) 1 $ iterate (const $ x*y) 1

-- 2

findPos :: Int -> Int -> [Int] -> Int
findPos _ _ [] = -1
findPos x pos (y:ys) 
    | x /= y = findPos x (pos + 1) ys
    | otherwise = pos

check :: Int -> [Int] -> [Int] -> Bool
check a ys zs
    | (a `elem` ys) && (not (a `elem` zs)) = True
    | (y < z) && (y > -1)  = True
    | otherwise = False 
    where
        y = findPos a 0 ys
        z = findPos a 0 zs 
    
selectFirst :: [Int] -> [Int] -> [Int] -> [Int]
selectFirst xs ys zs = filter (\a -> check a ys zs) xs

-- 3

myIterate :: (a -> a) -> a -> [a]
myIterate f x = scanl (\a b -> f a) x $ repeat x

-- 4 

type SymTab a = String -> Maybe a

empty :: SymTab a
empty = \_ -> Nothing

get :: SymTab a -> String -> Maybe a
get dict key = dict key

set :: SymTab a -> String -> a -> SymTab a
set dict key val = \x -> 
    if key == x 
       then Just val
       else dict x
       
-- 5

data Expr a
     = Val a
     | Var String
     | Sum (Expr a) (Expr a)
     | Sub (Expr a) (Expr a)
     | Mul (Expr a) (Expr a)
     deriving Show
     
eval :: (Num a) => SymTab a -> Expr a -> Maybe a
eval st (Val x) = Just x
eval st (Var x) = st x
eval st (Sum x y) = do
    z <- eval st x
    t <- eval st y
    return (z + t)
eval st (Sub x y) = do
    z <- eval st x
    t <- eval st y
    return (z - t)
eval st (Mul x y) = do
    z <- eval st x
    t <- eval st y
    return (z * t)
