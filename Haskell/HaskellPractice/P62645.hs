
-- 1

s2i :: String -> Int
s2i x = (read x) :: Int

computeSum :: [String] -> Int
computeSum s = foldl (\a b -> a + (s2i b)) 0 s

main = do
    contents <- getContents
    let val = computeSum $ words contents
    putStrLn $ show val
