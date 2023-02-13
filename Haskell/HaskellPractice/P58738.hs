main :: IO ()
main = return ()

data STree a = Nil | Node Int a (STree a) (STree a) deriving Show

-- 1

getTalla :: STree a -> Int
getTalla Nil = 0
getTalla (Node x y a b) = w + t + 1
    where
        w = getTalla a
        t = getTalla b

isOk :: STree a -> Bool
isOk Nil = True
isOk (Node x y a b) = p && q
    where 
        w = getTalla (Node x y a b)
        p = x == w
        q = i && o
        i = isOk a
        o = isOk b
-- 2

toArray :: STree a -> [a]
toArray Nil = []
toArray (Node _ x a b) = w ++ [x] ++ t 
    where 
        w = toArray a
        t = toArray b

nthElement :: STree a -> Int -> Maybe a
nthElement (Node x y a b) p
    | v < 0 || v >= l = Nothing
    | otherwise = Just $ w!!v
    where
        v = p - 1
        w = toArray $ Node x y a b
        l = length w
        
-- 3

toPair :: STree a -> [(Int,a)]
toPair Nil = []
toPair (Node x y a b) = w ++ p ++ t 
    where 
        w = toPair a
        t = toPair b
        p = zip [x] [y]

nthElement' :: STree a -> (a -> b) -> Int -> Maybe b
nthElement' (Node x y a b) f p
    | v < 0 || v >= l = Nothing
    | otherwise = Just $ f $ snd $ w!!v
    where
        v = p - 1
        w = toPair $ Node x y a b
        l = length w
        
mapToElements :: (a -> b) -> STree a -> [Int] -> [Maybe b]
mapToElements f (Node x y a b) l = map (\w -> nthElement' (Node x y a b) f w) l

-- 4

instance Functor (STree) where
    fmap f Nil = Nil
    fmap f (Node x y a b) = Node x (f y) (fmap f a) (fmap f b)






