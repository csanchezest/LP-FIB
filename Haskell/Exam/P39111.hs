import Data.List (sort)

type Pos = (Int, Int)

-- 1

dins :: Pos -> Bool
dins (x,y) = p && q where
    p = x > 0 && x < 9
    q = y > 0 && y < 9
    
-- 2

horizontalMoveSet :: Pos -> Int -> [Pos]
horizontalMoveSet (x,y) z = [(x+z, y-1),(x+z, y+1)]

verticalMoveSet :: Pos -> Int -> [Pos]
verticalMoveSet  (x,y) z = [(x-1, y+z),(x+1, y+z)]

createMovesList :: Pos -> [Pos]
createMovesList p = l ++ r ++ u ++ d where
    l = horizontalMoveSet p $ -2 
    r = horizontalMoveSet p 2
    u = verticalMoveSet p 2
    d = verticalMoveSet p $ -2

moviments :: Pos -> [Pos]
moviments p = filter (dins) $ createMovesList p

-- 3

potAnar3 :: Pos -> Pos -> Bool
potAnar3 p1 p2 = any (\x -> let l' = moviments x 
                            in any (\y -> let l'' = moviments y 
                                          in elem p2 l'') l') l where
    l = moviments p1

-- 4    

potAnar3' :: Pos -> Pos -> Bool
potAnar3' p1 p2 = do
    let l = moviments p1
    any (\x -> do
        let l' = moviments x
        any (\y -> do
            let l'' = moviments y
            elem p2 l'') l') l
