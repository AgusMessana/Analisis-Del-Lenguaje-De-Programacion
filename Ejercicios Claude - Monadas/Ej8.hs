{-
Programa compilado que cuente palabras: recibe un nombre de archivo por línea de comandos e imprime cuántas palabras tiene.
Puede servir words :: String -> [String], que separa un string en palabras.
-}
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  let input = head args
  txt <- readFile input
  let listW = words txt
  let cantW = length listW
  let sCantW = show cantW
  putStrLn ("Cantidad de palabras: " ++ sCantW)