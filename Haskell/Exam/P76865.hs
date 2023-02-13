data Tree a = Empty | Node a (Tree a) (Tree a)
    deriving (Show)

-- 1

instance Foldable Tree where
    foldr f i Empty = i
    foldr f i (Node x a b) = z where 
        y = foldr (f) i b
        t = f x y
        z = foldr (f) t a
        
-- 2

avg :: Tree Int -> Double
avg t = res where
    n = length t
    total = sum t
    comp = div total n
    res = fromIntegral comp
    
-- 3

getString :: Tree String -> String
getString Empty = " "
getString (Node x a b) = x ++ " " ++ (cat a) ++ " " ++ (cat b)

cat :: Tree String -> String
cat Empty = ""
cat t = foldl (\a b -> a ++ " " ++ b) f tl where
    l = words $ getString t
    tl = tail l
    f = head l
