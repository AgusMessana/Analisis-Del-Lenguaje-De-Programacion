{-
leerN :: Int -> IO [Int]
Lee n números del teclado (uno por línea) y los devuelve en una lista. Hacela con recursión
-}
main :: IO ()
main = do
  xs <- leerN 5
  print xs

leerN :: Int -> IO [Int]
leerN 0 = return []
leerN n = do
  ns <- getLine
  let x = read ns :: Int
  xs <- leerN (n - 1)
  return (x : xs)