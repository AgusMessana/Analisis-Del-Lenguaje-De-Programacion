{-
sumaHastaCero :: IO ()
Lee números uno por uno hasta que se ingresa un 0, y al final imprime la suma de todos.
-}
main :: IO ()
main = sumaHastaCero

sumaHastaCero :: IO ()
sumaHastaCero = do
  val <- acum 0
  let sval = show val
  putStrLn ("La suma de los valores es: " ++ sval)

acum :: Int -> IO Int
acum s = do
  putStrLn "Ingrese un valor: "
  sv <- getLine
  let v = read sv :: Int
  if v == 0
    then return s
    else acum (s + v)