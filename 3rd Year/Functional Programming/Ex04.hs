{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Daniel Nugent"  -- replace with your name
idno      =  "18326304"    -- replace with your student id
username  =  "nugentd2"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)


-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
ins k v Empty = Leaf k v
ins k v (Leaf a b)
  | k < a = (Branch (Leaf k v) Empty a b)
  | k > a = (Branch Empty (Leaf k v) a b)
  | otherwise = (Leaf k v)
ins k v (Branch left right a b)
  | k < a = (Branch (ins k v left) right a b)
  | k > a = (Branch left (ins k v right) a b)
  | otherwise = (Branch left right a v)
  
-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
lkp _ _ = error "lkp NYI"

-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 = 0
init2 = 0
init3 = 0

{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs a b c [] = (a, b, c)
getLASs a b c [d] = (a+1, b+d, c+(d*d))
getLASs a b c (d:ds) = getLASs (a+1) (b+d) (c+(d*d)) ds

-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)
