-- rational.hs

--imports for sorting stuff
import System.Random (randomRIO)
import Control.Monad (replicateM)


--
-- Implement your answers in this file.
--
-- There are few rules to follow:
--
--  - Don't change the MyRational type.
--  - Don't change any of the given function signatures.
--  - Use only functions from the standard prelude. Don't import any Haskell
--    modules.
--
-- You can implement your own helper functions if you like.
--

data MyRational = Frac Integer Integer

--
-- Given integers n and d, create a new rational with n as the numerator and d
-- as the denominator. Trying to create a rational with denominator 0 is an
-- error. Call the error function to crash the function, e.g. error
-- "makeRational: denominator can't be 0"
--

makeRational :: Integer -> Integer -> MyRational

makeRational n d = if (d==0)
    then
        error "Invalid Rational"
        else
            Frac n d


--
-- Returns the numerator of a rational.
--
getNum :: MyRational -> Integer
getNum (Frac n d) = n
-- ...


--
-- Returns the denominator of a rational.
--
getDenom :: MyRational -> Integer

getDenom (Frac n d) = d
--
-- Returns a pair of the numerator and denominator of a MyRational.
--
pair :: MyRational -> (Integer, Integer)
-- ...
pair (Frac n d) = (n, d)

--
-- Implement an instance of the show function that returns the usual string
-- representation of the rational. For instance, 5/3 would be the string
-- "5/3".
--
instance Show MyRational where
-- ...
 show (Frac n d) = show n ++ "/" ++ show d

--
-- Convert the fraction to a floating point value Returns the value as the
-- number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
-- etc. Hint: use fromIntegral.
--
toFloat :: MyRational -> Float
-- ...
toFloat (Frac n d) = ( num / denom )
  where num = fromIntegral n :: Float
        denom = fromIntegral d :: Float


--
-- Implement an instance of == that test if two MyRationals are equal. Be
-- careful if either is not in lowest terms!
--
instance Eq MyRational where
-- ...
 (Frac n1 d1) == (Frac n2 d2) = (n1 * d2) == (n2 * d1)

--
-- Implement an instance of compare x y that tests if the MyRationals x and y
-- are the same (return EQ), or x is less than y (return LT), or x is greater
-- than y (return GT). Be careful with negative values, and when x or y is not
-- in lowest terms!
--
instance Ord MyRational where
-- ...
 (Frac n1 d1) `compare` (Frac n2 d2) = (n1 * d2) `compare`(n2 * d1)
 

--
-- Return True if the given MyRational represents an integer, and False
-- otherwise. For example, 4/1, 21/3, and 0/99 are all integers.
--
isInt :: MyRational -> Bool
-- ...
isInt (Frac n d) = if (n `mod` d) == 0
  then True
  else False

--
-- Adds two given MyRationals and returns a new MyRational that is there sum.
--
add :: MyRational -> MyRational -> MyRational
-- ...
add (Frac n d) (Frac n1 d1) = (makeRational ((n * d1) + (n1 * d)) (d * d1))


--
-- Multiplies two given MyRationals and returns a new MyRational that is there
-- product.
--

mult :: MyRational -> MyRational -> MyRational
-- ...
mult (Frac n d) (Frac n1 d1) = (makeRational(n * n1)(d * d1))
--
-- Divides two given MyRationals and returns a new MyRational that is there
-- quotient. Call the error function if division by zero would occur.
--
divide :: MyRational -> MyRational -> MyRational
-- ...
divide (Frac n d) (Frac n1 d1) = if (d * n1 == 0)
    then
        error "Invalid Rational"
        else
            (makeRational (n * d1)(d* n1))

--
-- Inverts a given MyRational and returns a new one with the numerator and
-- denominator switched. For example, 2/3 inverts to 3/2. Call the error
-- function for 0 numerators, e.g. 0/3 inverts to 3/0, which is not a
-- rational.
--
invert :: MyRational -> MyRational
-- ...
invert (Frac n d) = if (n==0)
    then
        error "Invalid Rational"
        else
            Frac d n
--
-- Reduces a given MyRational and returns a new MyRational that is in lowest
-- terms. For example, 36/20 reduces tdo 9/5. Use the gcd function to help do
-- this. Be careful in the case where the numerator or denominator is
-- negative.
--
toLowestTerms :: MyRational -> MyRational
-- ...
toLowestTerms(Frac n d) = (makeRational n1 d1)
 where 
  n1 = (n `div` (gcd n  d))
  d1 = (d `div` (gcd n  d))

--
-- Given an integer, return a rational equal to 1/1 + 1/2 + ... + 1/n.
--
-- For example:
--
-- > harmonicSum 25
-- 34052522467/8923714800
--
harmonicSum :: Integer -> MyRational
-- ...
harmonicSum 0 = (makeRational 0 1)
harmonicSum 1 = (makeRational 1 1)
harmonicSum x =
 do 
  (add (makeRational 1 x) (harmonicSum(x - 1)))

--
-- Using insertion sort, list any list of values [a] for a type that
-- implements Ord.
--
-- For example:
--
-- > insertionSort [5,6,2,3,1,4]
-- [1,2,3,4,5,6]
--
-- > insertionSort ["one","two","three","four"]
-- ["four","one","three","two"]
--
-- > insertionSort [makeRational 2 2,makeRational 0 1,
--                  makeRational 4 5,makeRational (-1) 7]
-- [-1/7,0/1,4/5,2/2]
--
--derived from lecture notes
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y    = x:y:ys
                | otherwise = y : (insert x ys)

--
insertionSort :: Ord a => [a] -> [a]
-- ...
insertionSort []     = []
insertionSort (x:xs) = insert x (insertionSort xs)

 --Generating random list
 --derived from lecture notes
randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do z  <- randomRIO (1,10000)
                  zx <- randomList (n-1)
                  return (z:zx) 


--random list of pairs                  
randomListRational :: Int -> IO([(MyRational)])
randomListRational 0 = return []
randomListRational n = do a <- randomRIO (1,10000)
                          b <- randomRIO (1,10000)
                          dc <- randomListRational (n-1)
                          return ((makeRational a b):dc) 

--https://hackage.haskell.org/package/base-4.16.2.0/docs/Control-Monad.html#v:replicateM
--replicate derived from here
randomListStrings :: Int -> IO([String])
randomListStrings 0 = return []
randomListStrings n = do  m <- replicateM n (randomRIO ('0','9'))
                          ls <- randomListStrings (n-1)
                          return(m:ls)

--
-- When you're ready to test insertionSort, put a main function here that
-- calls it. See helloWorld.hs in the same folder for an example of how to do
-- this.
--



main = do 


         --testing makerational stuff
          print("getNum")
          print(getNum (makeRational 2 3))
          print("getDenom")
          print(getDenom (makeRational 2 3))
          print("pair")
          print(pair(makeRational 2 3))
          print("show")
          print(makeRational 2 1)
          print("toFoat")
          print(toFloat (makeRational 2 3))
          print("is equal")
          print((makeRational 1 3) == (makeRational 2 4))
          print("Compare")
          print((makeRational 1 2)`compare` (makeRational 1 3))
          print("is INT")
          print(isInt(makeRational 3 1))
          print("add")
          print(add(makeRational 1 4)(makeRational 5 2))
          print("multiply")
          print(mult(makeRational 3 4)(makeRational 1 2))
          print("divide")
          print(divide(makeRational 1 2)(makeRational 1 4))
          print("invert")
          print(invert(makeRational 1 1))
          print("toLowestTerms")
          print(toLowestTerms(makeRational 2 4))
          print("harmonicSum")
          print(harmonicSum 3)



        --insertionsort implementation
        --can be done on any type
          putStrLn "Calling insertionSort ..."
          print (insertionSort [1, 2, 4, 3])

          putStrLn ""
          putStrLn "Here's a list of 5 random numbers:"
          lst <- randomList 5
          putStrLn (show lst)

          putStrLn ""
          putStrLn "Here's a list of 5 random rationals:"
          rlst <- randomListRational 5
          putStrLn (show rlst)

          putStrLn ""
          putStrLn "Here's a list of 5 random strings:"
          slst <- randomListStrings 5
          putStrLn (show slst)

         
{- 
         --timing done in ghci
         --sorting random lists of ints with different sizes; can change the value for size
          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x
          
          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x
          
          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x
          
          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x
          
          lst <- (randomList 2000)
          let x = (insertionSort lst)
          print x

          
         


--sorting random lists of Rationals with different sizes; can change the value for size
          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y

          mlst <- (randomListRational 1000)
          let y = (insertionSort mlst)
          print y


--sorting random lists of strings with different sizes; can change the value for size
          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z

          slst <- (randomListStrings 1000)
          let z = (insertionSort slst)
          print z
-}
