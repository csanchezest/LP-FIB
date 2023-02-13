main :: IO ()
main = return ()

data Tree a = Node a (Tree a) (Tree a) | Empty 
    deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node t x y) = 1 + size x + size y 

height :: Tree a -> Int
height Empty = 0
height (Node t x y) = 
    let a = 1 + height x
        b = 1 + height y
    in
        if a>b
           then a
           else b

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node t x y) (Node p a b) = (t == p) && (equal x a) && (equal y b)

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic _ Empty = False
isomorphic Empty _ = False
isomorphic (Node t x y) (Node p a b) = t==p && ((isomorphic x b && isomorphic y a) || (isomorphic x a && isomorphic y b))

preOrder :: Tree a -> [a] 
preOrder Empty = []
preOrder (Node t x y) = [t] ++ (preOrder x) ++ (preOrder y)

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node t x y) = (postOrder x) ++ (postOrder y) ++ [t]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node t x y) = (inOrder x) ++ [t] ++ (inOrder y)


breadthFirst :: Tree a -> [a]
breadthFirst x = goThroughBreadth [x]

goThroughBreadth:: [Tree a] -> [a]
goThroughBreadth [] = []
goThroughBreadth (Empty:xs) = goThroughBreadth xs
goThroughBreadth ((Node t x y):xs) = t:(goThroughBreadth $ xs ++ [x,y])


--split :: Eq a => a -> [a] -> ([a],[a])
--split teoricament ja esta implementada a nivell de llista

--funcio que et pilla la part que esta abans d'un determinat valor (el node arrel de l'arbre probablement) i el que hi ha despres
--span fa el que hauria de fer split

normalize :: [a] -> [a]
normalize [x] = []
normalize (_:xs) = xs

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build (x:xs) ys = 
    let
        (pl,pr) = span (/=x) ys
        (li,ri) = splitAt (length $ pl) xs
        pr_r = normalize pr
        l = build li pl 
        r = build ri pr_r
    in
        Node x l r

--imaginar arbre amb nodes 
--       1
--      / \
--     5   4
--    / \  |\
--   2  3  7 (buit)
-- Preordre: [1,5,2,3,4,7]
-- Inordre:  [2,5,3,1,7,4]
-- Seria algo tipo: node 1; build [5,2,3] [2,5,3], build [4,7] [7,4]
-- build [] [] = []
-- build (x:xs) ys = Node x izq x ys der x ys
--  where
--   iz = x xs =
--   der x ys = 


overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap f Empty Empty = Empty
overlap f t Empty = t
overlap f Empty t = t
overlap f (Node t x y) (Node p l r) = 
    let
        z = f t p
        w = overlap f x l
        q = overlap f y r
    in
        (Node z w q)
