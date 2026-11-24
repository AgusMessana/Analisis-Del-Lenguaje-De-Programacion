``` haskell
## Para evaluar expresiones con variables, se define una mónada que lee un entorno (una lista de pares nombre–valor) y puede fallar:

newtype Env a = E { runEnv :: [(String, Int)] -> Maybe a }

## a) Dar la instancia de Monad para Env.

## b) Probar que cumple monad.1.

## c) Definir lookupVar :: String -> Env Int, que busca el valor de una variable en el entorno y falla si no está. Podés usar lookup :: Eq a => a -> [(a, b)] -> Maybe b de Haskell.

## d) Dado el tipo
data Exp = Num Int | Var String | Add Exp Exp
## definir eval :: Exp -> Env Int usando las operaciones de a) y c), sin acceder a la estructura interna de la mónada.

## e) Escribir un programa (main) que pida al usuario el valor de la variable "x", evalúe la expresión Add (Var "x") (Num 1) en el entorno [("x", valor)], e imprima el resultado, o "Variable no definida" si la evaluación falla.

## a)
runEnv :: Env a -> ([(String, Int)] -> Maybe a)
runEnv (E h) = h

instance Monad Env where
  return :: a -> Env a
  return x = E (\p -> Just x)

  (>>=) :: Env a -> (a -> Env b) -> Env b
  (E h) >>= f = E (\p -> case h p of
                          Nothing -> Nothing
                          Just x -> runEnv (f x) p)

## b)
monad.1
∀y :: a, k :: a -> Env b, return y >>= k = k y
return y >>= k
= {Env. 1}
E (\p -> Just y) >>= k
= {Env. 2}
E(\p' -> case (\p -> Just y) p' of
          Nothing -> Nothing
          Just x -> runEnv (k x) p')
= {B-reducción}
E (\p' -> case (Just y) of
          Nothing -> Nothing
          Just x -> runEnv (k x) p')
= {case Just y: Just x -> runEnv (k x) p': x = y}
E (\p' -> runEnv (k y) p')
= {n-reducción}
E (runEnv (k y))
= {Sea k y = E g, g :: [(String, Int)] -> Maybe b}
E (runEnv (E g))
= {def. runEnv}
E g
= {k y = E g}
k y //

## c)
lookup :: Eq a => a -> [(a, b)] -> Maybe b
lookupVar :: String -> Env Int
lookupVar str = E (\s -> lookup str s)

## d)
data Exp = Num Int | Var String | Add Exp Exp
eval :: Exp -> Env Int
eval (Num n) = return n
eval (Var s) = lookupVar s
eval (Add e1 e2) = do 
  v1 <- eval e1
  v2 <- eval e2
  return (v1 + v2)

## e)
Escribir un programa (main) que pida al usuario el valor de la variable "x", evalúe la expresión Add (Var "x") (Num 1) en el entorno [("x", valor)], e imprima el resultado, o "Variable no definida" si la evaluación falla.

main :: IO ()
main = do
  putStrLn "Ingrese el valor de x"
  svalx <- getLine
  let valx = read svalx :: Int
  let res = runEnv (eval (Add (Var "x") (Num 1))) [("x", valx)]
  case res of
    Nothing -> putStrLn "Variable no definida"
    Just v  -> putStrLn (show v)

´´´