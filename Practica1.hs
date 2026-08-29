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
