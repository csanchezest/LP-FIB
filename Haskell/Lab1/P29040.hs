main :: IO ()
main = return ()

insert :: [Int] -> Int -> [Int]
insert [] y = [y]
insert (x:xs) y
    | y <= x = [y] ++ [x] ++ xs
    | otherwise = [x] ++ insert xs y

isort :: [Int] -> [Int] 
isort [] = []
isort [x] = [x]
isort (x:xs) =
    let y = isort xs
    in insert y x
    
remove :: [Int] -> Int -> [Int] 
remove [] x = []
remove (x:xs) y
    | x==y = xs
    | otherwise = [x] ++ remove xs y

myLength :: [Int] -> Int 
myLength [] = 0
myLength (_:x) = 1 + myLength x

ssort :: [Int] -> [Int]
ssort [] = []
ssort [x] = [x]
ssort xs = 
    let min = minimum xs
        m = remove xs min
    in [min] ++ ssort m

merge :: [Int] -> [Int] -> [Int] 
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys)
    | x>=y = [y] ++ merge (x:xs) ys
    | otherwise = [x] ++ merge (y:ys) xs

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort x =
    let n = div (myLength x) 2
        (a,b) = splitAt n x
    in merge (msort a) (msort b)

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) =
  let leftS = qsort [a | a <- xs, a <= x]
      rightS = qsort [a | a <- xs, a > x]
  in  leftS ++ [x] ++ rightS
  
genQsort :: Ord a => [a] -> [a] 
genQsort [] = []
genQsort (x:xs) =
  let leftS = genQsort [a | a <- xs, a <= x]
      rightS = genQsort [a | a <- xs, a > x]
  in  leftS ++ [x] ++ rightS





