main :: IO ()
main = return ()

data Tree a = Empty | Node a (Tree a) (Tree a)

-- 1

instance Show a => Show (Tree a) where
    show Empty = "()"
    show (Node a x y) = "(" ++ (show x) ++ "," ++ (show a) ++ "," ++ (show y) ++ ")"
    
-- 2

instance Functor Tree where
    fmap f Empty = Empty
    fmap f (Node a x y) = Node (f a) (fmap f x) (fmap f y)

doubleT :: Num a => Tree a -> Tree a 
doubleT t = (*2) <$> t

-- 3

data Forest a = Forest [Tree a] deriving (Show)

instance Functor Forest where
    fmap f (Forest l) = Forest $ map (\x -> f <$> x) l
    
doubleF :: Num a => Forest a -> Forest a 
doubleF f = (*2) <$> f
