``` haskell
newtype SM s a = SM { runSM :: s -> Maybe (a, s) }

runSM :: SM s a -> (s -> Maybe (a, s))
runSM (SM h) = h

instance Monad (SM s) where
  return :: a -> SM s a
  return x = SM (\s -> Just (x, s))

  (>>=) :: SM s a -> (a -> SM s b) -> SM s b
  (SM h) >>= f = SM (\s -> case h s of
                            Nothing -> Nothing
                            Just (x, s') -> runSM (f x) s')

## 2. Definir
## getSM :: SM s s, que devuelve el estado sin cambiarlo
## putSM :: s -> SM s (), que reemplaza el estado
## failSM :: SM s a, que siempre falla

getSM :: SM s s
getSM = SM (\s -> Just (s, s))

putSM :: s -> SM s ()
putSM st = SM (\s -> Just ((), st))

failSM :: SM s a
failSM = SM (\s -> Nothing)
´´´