main :: IO ()
main = return ()

data Queue a = Queue [a] [a]
     deriving (Show)

instance Functor Queue where
    fmap f (Queue l r) = Queue (map f l) (map f r)

--translation :: Num b => b -> Queue b -> Queue b

create :: Queue a
create = Queue [] []

unio :: Queue a -> Queue a -> Queue a
unio (Queue l1 r1) (Queue l2 r2) = Queue (l1 ++ (reverse r1) ++ l2 ++ (reverse r2)) []

instance Applicative Queue where
    pure x = Queue [x] []
    --en l y r hay funciones(!!)
    (Queue l r) <*> (Queue x y) = Queue [f g | f <- l ++ (reverse r), g <- x ++ (reverse y)] []

instance Monad Queue where
    return x = Queue [x] []
    (Queue l r) >>= f = unio (f l) (f r)



