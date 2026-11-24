``` haskell
Se define el siguiente tipo para computaciones que llevan un registro de mensajes:
newtype Logger a = L { runLogger :: (a, [String]) }

## a) Dar la instancia de Monad para Logger y probar que cumple monad.1 y monad.2.
## b) Definir logMsg :: String -> Logger (), que agrega un mensaje al registro.
## c) Usando las operaciones de a) y b), y sin acceder a la estructura interna de la mónada, definir factLog :: Int -> Logger Int, que calcula el factorial y registra un mensaje por cada paso. Por ejemplo, factLog 3 podría registrar ["fact 0 = 1", "fact 1 = 1", "fact 2 = 2", "fact 3 = 6"].
## d) Escribir un programa (main) que lea un número del teclado, calcule su factorial con factLog, imprima cada mensaje del registro en una línea y al final imprima "Resultado: N".

## a)
runLogger :: Logger a -> (a, [String])
runLogger (L p) = p

instance Monad Logger where
  return :: a -> Logger a
  return x = L (x, [])

  (>>=) :: Logger a -> (a -> Logger b) -> Logger b
  (L (x, s)) >>= f = let (y, s') = runLogger (f x)
                      in L (y, s ++ s')

## b)
logMsg :: String -> Logger ()
logMsg msj = L ((), [msj])

## c)
factLog :: Int -> Logger Int
factLog 0 = do logMsg "fact 0 = 1"
               return 1
factLog n = do r <- factLog (n - 1)
               let res = n * r
               logMsg ("fact " ++ show n ++ " = " ++ show res)
               return res

## d)
main :: IO ()
main = do
  putStrLn "Ingrese un número entero positivo"
  sn <- getLine
  let n = read sn :: Int
  let (x, s) = runLogger (factLog n)
  imprimir s
  putStrLn ("Resultado: " ++ show x)

imprimir :: [String] -> IO ()
imprimir [] = return ()
imprimir (x : xs) = do 
  putStrLn x
  imprimir xs
´´´