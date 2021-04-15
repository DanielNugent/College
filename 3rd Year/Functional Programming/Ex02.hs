{- butrfeld Andrew Butterfield -}
module Ex02 where

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

-- Datatypes and key functions -----------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Dict String d -> String -> Either String d
find []             name              =  Left ("undefined var "++name)
find ( (s,v) : ds ) name | name == s  =  Right v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- do not change anything above !

-- Part 1 : Evaluating Expressions -- (50 test marks, worth 25 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return `Left msg` if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.
  -- see test outcomes for the precise format of those messages

eval :: EDict -> Expr -> Either String Double

eval _ (Val x) = Right x
eval d (Var x) = find d x
eval d (Add x y) = case(eval d x, eval d y) of
                 (Right a, Right b) -> Right (a + b)
                 (Left a, _) -> Left (a)
                 (_, Left b) -> Left (b)
                 

eval d (Sub x y) = case(eval d x, eval d y) of
                 (Right a, Right b) -> Right (a - b)
                 (Left a, _) -> Left (a)
                 (_, Left b) -> Left (b)

eval d (Mul x y) = case(eval d x, eval d y) of
                 (Right a, Right b) -> Right (a * b)
                 (Left a, _) -> Left (a)
                 (_, Left b) -> Left (b)
                 

eval d (Dvd x y) = case(eval d x, eval d y) of
                 (Right a, Right b) -> if b == 0.0 then Left ("div by zero") else Right (a / b)
                 (Left a, _) -> Left (a)
                 (_, Left a) -> Left (a)
                 

eval d (Def x y z) = case eval d y of
                     Left a  ->  Left (a)
                     Right a  ->  eval (define d x a) z
                     

-- Part 1 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + z         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}


law1 e = case(e) of
        (Add x y) -> Just(Add y x)
        _ -> Nothing

law2 :: Expr -> Maybe Expr
law2 e = case(e) of
      (Add x (Add y z)) -> Just(Add (Add x y) z)
      _ -> Nothing

law3 :: Expr -> Maybe Expr
law3 e = case(e) of
      (Sub x (Add y z)) -> Just(Sub (Sub x y) z)
      _ -> Nothing

law4 :: Expr -> Maybe Expr
law4 e = case(e) of
           (Mul (Add x y) (Sub p q)) -> if x==p && y==q then Just(Sub (Mul x x) (Mul y y))
               else Nothing
           _ -> Nothing
