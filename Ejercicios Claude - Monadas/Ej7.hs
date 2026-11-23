{-
eco :: IO ()
Lee líneas una por una e imprime cada una en mayúsculas, hasta que se ingresa la palabra "fin". Ahí imprime "Chau" y termina
-}
import Data.Char (toUpper)

main :: IO ()
main = eco

eco :: IO ()
eco = do
  word <- getLine
  if word == "fin"
    then putStrLn "Chau"
    else do
      let wordU = map toUpper word
      putStrLn wordU
      eco