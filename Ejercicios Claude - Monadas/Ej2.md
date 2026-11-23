``` haskell
newtype Counter a = C { runCounter :: Int -> (a, Int) }

runCounter :: Counter a -> (Int -> (a, Int))
runCounter (C h) = h

instance Monad Counter where
  return :: a -> Counter a
  return x = C (\n -> (x, n))

  (>>=) :: Counter a -> (a -> Counter b) -> Counter b
  (C h) >>= f = C (\n -> let (x, m) = h n
                          in runCounter (f x) m)

## 1. Probar que es mónada
## monad.1
## ∀y :: a, k :: a -> Counter b, return y >>= k = k y
return y >>= k
= {Counter. 1}
C (\n -> (y, n)) >>= k
= {Counter. 2}
C (\n' -> let (x, m) = (\n -> (y, n)) n'
           in runCounter (k x) m)
= {B-reducción}
C (\n' -> let (x, m) = (y, n')
          in runCounter (k x) m)
= {let (x, m) = (y, n'): x = y, m = n'}
C (\n' -> runCounter (k y) n')
= {n-reducción}
C (runCounter (k y))
= {Sea k y = C g, g :: Int -> (b, Int)}
C (runCounter (C g))
= {def. runCounter}
C g
= {k y = C g}
k y //

## 2. Definir
## a. tick :: Counter (), que suma uno al contador.
## b. current :: Counter Int, que lee el contador sin cambiarlo.

tick :: Counter ()
tick = C (\n -> ((), n + 1))

current :: Counter Int
current = C (\n -> (n, n))
´´´