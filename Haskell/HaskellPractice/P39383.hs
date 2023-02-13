main :: IO ()
main = return ()

-- 1

factorial :: Float -> Float
factorial 0.0 = 1.0
factorial f = foldl (\a b -> a*b) f [1..f-1]

exps :: Float -> [Float]
exps f = scanl (\x y -> (f ** y) / (factorial y)) 1.0 $ [1.0,2.0..]

-- 2

exponencial :: Float -> Float -> Float
exponencial f e = sum $ takeWhile (>= e) $ exps f
{-exponencial f e = sum $ takeWhile (>= e) x
    where 
        l = exps f
        aux = tail l
        x = zipWith (\a b -> abs(a-b)) aux $ tail aux-}
