module Practica1 where

import Parsing
import Control.Applicative hiding (many)

-- =============================================================================
-- # Ejercicio 2
-- =============================================================================
expr :: Parser Int
expr = do t <- term
          (do symbol "+"
              e <- expr
              return (t + e))
           <|> (do symbol "-"
                   e <- expr
                   return (t - e))
           <|> return t

term :: Parser Int
term = do f <- factor
          (do symbol "*"
              t <- term
              return (f * t))
           <|> (do symbol "/"
                   t <- term
                   return (f `div` t))
           <|> return f

factor :: Parser Int
factor = (do symbol "("
             e <- expr
             symbol ")"
             return e)
          <|> natural

-- =============================================================================
-- # Ejercicio 3
-- =============================================================================
transformador :: Parser a -> Parser a
transformador p = (do symbol "("
                      t <- p
                      symbol ")"
                      return t)
                   <|> p

-- =============================================================================
-- # Ejercicio 4
-- =============================================================================
data Expr = Num Int | BinOp Op Expr Expr deriving Show
data Op = Add | Mul | Min | Div deriving Show

expr' :: Parser Expr
expr' = do
  t <- term'
  (do symbol "+"
      e <- expr'
      return (BinOp Add t e))
   <|> (do symbol "-"
           e <- expr'
           return (BinOp Min t e))
   <|> return t

term' :: Parser Expr
term' = do
  f <- factor'
  (do symbol "*"
      t <- term'
      return (BinOp Mul f t))
   <|> (do symbol "/"
           t <- term'
           return (BinOp Div f t))
   <|> return f

factor' :: Parser Expr
factor' = (do symbol "("
              e <- expr'
              symbol ")"
              return e)
           <|> (do n <- natural
                   return (Num n))

-- =============================================================================
-- # Ejercicio 5
-- =============================================================================
data Basetype = DInt | DChar | DFloat deriving Show
type Hasktype = [Basetype]

{-
hasktype -> basetype ('->' hasktype | ε)
basetype -> 'Int' | 'Char' | 'Float'
-}

basetype :: Parser Basetype
basetype = (do symbol "Int"
               return DInt)
             <|> (do symbol "Char"
                     return DChar)
             <|> (do symbol "Float"
                     return DFloat)

hasktype :: Parser Hasktype
hasktype = sepBy1 basetype (symbol "->")

-- =============================================================================
-- # Ejercicio 6
-- =============================================================================
data ElemList = EInt Int | EChar Char deriving Show
type HeterList = [ElemList]

{-
formList → '[' heterList ']'
heterList -> ε | elemList (',' heterList | ε)
elemList -> num | car
car -> "'" c "'"
-}

car :: Parser ElemList
car = do symbol "'"
         c <- item
         symbol "'"
         return (EChar c)

elemList :: Parser ElemList
elemList = (do n <- natural
               return (EInt n))
            <|> car

heterList :: Parser HeterList
heterList = sepBy elemList (symbol ",")

formList :: Parser HeterList
formList = do symbol "["
              l <- heterList
              symbol "]"
              return l

-- =============================================================================
-- # Ejercicio 7
-- =============================================================================
data Hasktype' = DInt' | DChar' | DFloat' | Fun Hasktype' Hasktype' deriving Show

{-
hasktype' -> factHask ('->' hasktype' | ε)
factHask -> '(' hasktype' ')' | basetype'
basetype' -> 'Int' | 'Char' | 'Float'
-}

basetype' :: Parser Hasktype'
basetype' = (do symbol "Int"
                return DInt')
             <|> (do symbol "Char"
                     return DChar')
             <|> (do symbol "Float"
                     return DFloat')

factHask :: Parser Hasktype'
factHask = (do symbol "("
               ht <- hasktype'
               symbol ")"
               return ht)
             <|> basetype'

hasktype' :: Parser Hasktype'
hasktype' = do
  fh <- factHask
  (do symbol "->"
      ht <- hasktype'
      return (Fun fh ht))
   <|> return fh
