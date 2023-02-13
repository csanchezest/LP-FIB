main :: IO ()
main = return ()

fizzBuzz :: [Either Int String]
fizzBuzz = map (\a -> 
    if mod a 3 == 0 && mod a 5 == 0
    then Right "FizzBuzz"
    else 
    if mod a 3 == 0
        then Right "Fizz"
        else 
        if mod a 5 == 0
            then Right "Buzz"
            else Left a) [0..]
