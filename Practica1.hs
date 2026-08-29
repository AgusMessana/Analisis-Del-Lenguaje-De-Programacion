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

-- =============================================================================
-- # Ejercicio 8
-- =============================================================================
{-
Gramática que asocia a derecha
expr → expr (’+’ term | ’-’ term) | term
term → term (’*’ factor | ’/’ factor ) | factor
factor → digit | ’(’ expr ’)’
digit → ’0’ | ’1’ | ... | ’9’

Gramática que asocia a izquierda
expr -> term expr'
expr' -> ε | ('+' term | '-' term) expr'
term -> factor term'
term' -> ε | ('*' factor | '/' factor) term'
factor -> digit | '(' expr ')'
digit -> '0' | '1' | ... | '9'
-}

expr1 :: Parser Expr
expr1 = do t <- term1
           expr2 t
expr2 :: Expr -> Parser Expr
expr2 acc = (do symbol "+"
                t <- term1
                expr2 (BinOp Add acc t))
             <|> (do symbol "-"
                     t <- term1
                     expr2 (BinOp Min acc t))
             <|> return acc

term1 :: Parser Expr
term1 = do f <- factor1
           term2 f
term2 :: Expr -> Parser Expr
term2 acc = (do symbol "*"
                f <- factor1
                term2 (BinOp Mul acc f))
             <|> (do symbol "/"
                     f <- factor1
                     term2 (BinOp Div acc f))
             <|> return acc

factor1 :: Parser Expr
factor1 = (do symbol "("
              e <- expr1
              symbol ")"
              return e)
           <|> (do n <- natural
                   return (Num n))

-- =============================================================================
-- # Ejercicio 9
-- =============================================================================
{-
declaration -> type specifier declarator ’;’
declarator -> ’*’ declarator | direct declarator
direct declarator -> direct declarator ’[’ constant expression ’]’ | ’(’ direct declarator ’)’ | identifier
type specifier -> ’int’ | ’char’ | ’float’
constant expression -> number

Gramática con asociación a izquierda
declaration -> type_specifier declarator ’;’
declarator -> ’*’ declarator | direct_declarator
direct_declarator -> ('(' direct_declarator ')' | identifier) direct_declarator'
direct_declarator' -> ε | '[' constant_expression ']' direct_declarator'
type_specifier -> ’int’ | ’char’ | ’float’
constant_expression -> number
-}

data TipoBase = Bint | Bchar | Bfloat deriving Show
data Declarador =  Pun Declarador | Nom String | Arr Declarador Int deriving Show
data Declaracion = Decl TipoBase Declarador deriving Show

typeSpecifier :: Parser TipoBase
typeSpecifier = (do symbol "int"
                    return Bint)
                 <|> (do symbol "char"
                         return Bchar)
                 <|> (do symbol "float"
                         return Bfloat)

directDeclarator' :: Declarador -> Parser Declarador
directDeclarator' acc = (do symbol "["
                            cE <- natural
                            symbol "]"
                            directDeclarator' (Arr acc cE))
                         <|> return acc

directDeclarator :: Parser Declarador
directDeclarator = do
  d <- (do symbol "("
           dD <- directDeclarator
           symbol ")"
           return dD
        <|> do iD <- identifier
               return (Nom iD))
  directDeclarator' d

declarator :: Parser Declarador
declarator = (do symbol "*"
                 d <- declarator
                 return (Pun d))
              <|> directDeclarator

declaration :: Parser Declaracion
declaration = do tS <- typeSpecifier
                 d <- declarator
                 symbol ";"
                 return (Decl tS d)