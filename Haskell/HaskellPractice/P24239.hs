main :: IO ()
main = return ()

-- 1

convertChar :: Char -> Int
convertChar c
    | c == 'I' = 1
    | c == 'V' = 5
    | c == 'X' = 10
    | c == 'L' = 50
    | c == 'C' = 100
    | c == 'D' = 500
    | otherwise = 1000

computeValue :: String -> [Int] -> [Int]
computeValue [] x = x
computeValue (x:xs) [] = computeValue xs [y] 
    where
        y = convertChar x
computeValue (x:xs) ys
    | y < z = computeValue xs [-y] ++ ys
    | otherwise = computeValue xs [y] ++ ys 
    where
        z = head ys
        y = convertChar x


roman2int :: String -> Int 
roman2int s = sum $ computeValue (reverse s) []

-- 2

roman2int' :: String -> Int
roman2int' s = sum $ scanl (\a b -> let x = convertChar b 
                                   in 
                                       if (a /= 0 && x < a) 
                                          then -x
                                          else x) 0 $ reverse s

-- 3

arrels :: Float -> [Float]
arrels x = iterate (\y -> (1/2) * (y + (x/y))) x
{-arrels x = scanl (\a b -> let 
                              t = 1/2 
                              w = x/a 
                          in
                          t * (a + w)) x $ repeat 1-}
                              
-- 4

arrel :: Float -> Float -> Float
arrel f e = snd $ head $ dropWhile (\a -> (fst a) >e) p
    where
        l = arrels f
        d = zipWith (\a b -> abs(a-b)) l $ tail l
        p = zip d $ tail l
{-arrel f e = fst $ head $ dropWhile (\(a,b) -> b > e) $ zip t $ zipWith (\a b -> abs(b-a)) w t
    where
        w = arrels f
        t = tail w-}
        
-- 5

data LTree a = Leaf a | Node (LTree a) (LTree a)

instance Show a => Show (LTree a) where
    show (Leaf a) = "{" ++ (show a) ++ "}"
    show (Node a b) = "<" ++ (show a) ++ "," ++ (show b) ++ ">"
    
-- 6
split :: [a] -> ([a],[a])
split xs = 
    if ((mod n 2) == 0) 
       then splitAt m xs 
       else splitAt (m+1) xs 
    where
        n = length xs
        m = div n 2

build :: [a] -> LTree a
build [x] = Leaf x
build xs = Node (build a) (build b)
    where
        (a,b) = split xs

-- 7

instance Functor (LTree) where
    fmap f (Leaf a) = Leaf $ f a
    fmap f (Node a b) = Node (fmap f a) (fmap f b)
    
instance Applicative (LTree) where
    pure x = Leaf x
    (Leaf f) <*> x = fmap f x
    (Node fe fd) <*> (Node a b) = Node (fe <*> a) (fd <*> b)
    
instance Monad (LTree) where
    return x = Leaf x
    Leaf x >>= f = f x
    (Node a b) >>= f = Node (a >>= f) (b >>= f)

buildList :: LTree a -> [a]
buildList (Leaf x) = [x]
buildList (Node a b) = x ++ y 
    where
        x = buildList a
        y = buildList b
    
zipTrees :: LTree a -> LTree b -> LTree (a,b)
zipTrees (Leaf x) (Leaf y) = Leaf $ (x,y)
zipTrees (Node a b) (Node x y) = Node (zipTrees a x) (zipTrees b y)

sameTreeStructure :: LTree a -> LTree b -> Bool
sameTreeStructure (Leaf x) (Leaf y) = True
sameTreeStructure (Leaf x) _ = False
sameTreeStructure _ (Leaf x) = False
sameTreeStructure (Node a b) (Node x y) = w && q 
    where
        w = sameTreeStructure a x
        q = sameTreeStructure b y

zipLTrees :: LTree a -> LTree b -> Maybe (LTree (a,b))
zipLTrees tx ty = do
    if cond
       then do
           Just w 
       else Nothing 
    where
        cond = sameTreeStructure tx ty
        w = zipTrees tx ty
        
replace :: Eq a => [(a,b)] -> LTree a -> LTree (Maybe b)
replace l t = t >>= f where f x = Leaf (lookup x l)
