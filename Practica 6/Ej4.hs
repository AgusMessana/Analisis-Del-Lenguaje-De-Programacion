main :: IO ()
main = juego [5, 4, 3, 2, 1] 1

tablero :: [Int] -> Int -> IO ()
tablero [] _ = return ()
tablero (x : xs) i = do
  putStr (show i ++ ": ")
  putStrLn (replicate x '*')
  tablero xs (i + 1)

sacar :: [Int] -> Int -> Int -> [Int]
sacar (x : xs) f c =
  if f == 1
    then (x - c) : xs
    else x : sacar xs (f - 1) c

valida :: [Int] -> Int -> Int -> Bool
valida t f c =
  f >= 1
    && f <= length t
    && c >= 1
    && (t !! (f - 1)) >= c

juego :: [Int] -> Int -> IO ()
juego t j = do
  tablero t 1
  putStrLn ("Turno del jugador " ++ show j)
  putStrLn "Elija la fila."
  fs <- getLine
  let f = read fs :: Int
  putStrLn "Elija la cantidad."
  cs <- getLine
  let c = read cs :: Int
  if valida t f c
    then do
      let t' = sacar t f c
      if all (== 0) t'
        then putStrLn ("El jugador " ++ show j ++ " gana")
        else juego t' (3 - j)
    else do
      putStrLn "Jugada inválida."
      juego t j