module Ex01 where
import Data.Char (toUpper)
import Data.List (group)




declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]


{- Part 1

Write a function 'raise' that converts a string to uppercase

Hint: 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged.
It is imported should you want to use it.

-}
raise :: String -> String
raise [] = []
raise (x:xs) = toUpper x : raise xs

{- Part 2

Write a function 'nth' that returns the nth element of a list.
Hint: the test will answer your Qs

-}
nth :: Int -> [a] -> a
nth _ [] = undefined
nth i (x:xs) | i == 1 = x 
             | otherwise = nth (i-1) xs


{- Part 3

Write a function `commonLen` that compares two sequences
and reports the length of the prefix they have in common.

-}
commonLen :: Eq a => [a] -> [a] -> Int
commonLen2 :: Eq a => [a] -> [a] -> Int -> Int
commonLen [] _ = 0
commonLen _ [] = 0
commonLen (x:xs) (y:ys) | x == y = commonLen2 xs ys 1
                        | otherwise = 0
commonLen2 [] _ i = i
commonLen2 _ [] i = i
commonLen2 (x:xs) (y:ys) i | x == y = commonLen2 xs ys (i+1)
                           | otherwise = i
{- Part 4

(TRICKY!) (VERY!)

Write a function `runs` that converts a list of things
into a list of sublists, each containing elements of the same value,
which when concatenated together give the same list

So `runs [1,2,2,1,3,3,3,2,2,1,1,4]`
 becomes `[[1],[2,2],[1],[3,3,3],[2,2],[1,1],[4]]`

Hint:  `elem :: Eq a => a -> [a] -> Bool`

HINT: Don't worry about code efficiency
       Seriously, don't!

-}
runs :: Eq a => [a] -> [[a]]           
runs x = group x
