main :: IO ()
main = return ()

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f x [] = x
myFoldl f x (y:ys) = myFoldl f (f x y) ys

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f x [] = x
myFoldr f x (y:ys) = f y $ myFoldr f x ys

myIterate :: (a -> a) -> a -> [a]
myIterate f x = [x] ++ (myIterate f (f x))

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil f g x 
     | f x = x
     | otherwise = myUntil f g (g x)

myMap :: (a -> b) -> [a] -> [b]
myMap f x = myFoldr (\y ys-> (f y):ys) [] x

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f x  = myFoldr (\w t -> if (f w) then [w]++t else t) [] x
     
myAll :: (a -> Bool) -> [a] -> Bool
myAll f x = myFoldr (\y z -> (f y) && z) True x

myAny :: (a -> Bool) -> [a] -> Bool
myAny f x = myFoldr (\y z -> (f y) || z) False x

myZip :: [a] -> [b] -> [(a, b)]
myZip x [] = []
myZip [] y = []
myZip (x:xs) (y:ys) = [(x,y)] ++ myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f x y = myFoldr (\w t -> (f (fst w) (snd w)):t) [] $ myZip x y
