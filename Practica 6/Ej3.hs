main :: IO ()
main = juego 42

juego :: Int -> IO ()
juego num = do
  putStrLn "Intente adivinar el número."
  adivina num

adivina :: Int -> IO ()
adivina num = do
  putStr "> "
  ns <- getLine
  let n = read ns
  if n == num
    then putStrLn "El número es correcto!"
    else
      if n < num
        then do
          putStrLn "El número es mayor."
          adivina num
        else do
          putStrLn "El número es menor."
          adivina num