``` haskell
newtype Parser a = P { runP :: String -> [(a, String)] }

runP :: Parser a -> (String -> [(a, String)])
runP (P h) = h

instance Monad Parser where
  return :: a -> Parser a
  return x = P (\s -> [(x, s)])

  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  (P h) >>= f = P (\s -> [r | (x, s') <- h s, r <- runP (f x) s'])
´´´