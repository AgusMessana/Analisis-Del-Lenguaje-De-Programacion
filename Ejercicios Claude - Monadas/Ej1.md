```haskell
newtype Reader e a = R { runReader :: e -> a }

runReader :: Reader e a -> (e -> a)
runReader (R h) = h

instance Monad (Reader e) where
  return :: a -> Reader e a
  return x = R (\e -> x)

  (>>=) :: Reader e a -> (a -> Reader e b) -> Reader e b
  (R h) >>= f = R (\e -> let x = h e
                          in runReader (f x) e)

## 1. Probar que es mónada
## monad.1
## ∀y :: a, k :: a -> Reader e b, return y >>= k = k y
return y >>= k
= {Reader e.1}
R (\e -> y) >>= k
= {Reader e.2}
R (\e' -> let x = (\e -> y) e'
           in runReader (k x) e')
= {B-reducción}
R (\e' -> let x = y
           in runReader (k x) e')
= {let x = y: x = y}
R (\e' -> runReader (k y) e')
= {n-reducción}
R (runReader (k y))
= {Sea k y = R g, g :: e -> b}
R (runReader (R g))
= {def. runReader}
R g
= {R g = k y}
k y //

## monad.2
## ∀t :: Reader e a, t >>= return = t. Sea t = R h
t >>= return = (R h) >>= return
= {Reader e.2}
R (\e -> let x = h e
          in runReader (return x) e)
= {Reader e.1}
R (\e -> let x = h e
          in runReader (R (\e' -> x)) e)
= {def. runReader}
R (\e -> let x = h e
          in (\e' -> x) e)
= {B-reducción}
R (\e -> let x = h e
          in x)
= {let x = h e: x = h e}
R (\e -> h e)
= {n-reducción}
R h = t //

## monad.3
## ∀t :: Reader e a, k :: a -> Reader e b, j :: b -> Reader e c, 
## t >>= (\x -> k x >>= j) = (t >>= k) >>= j. Sea t = R h

t >>= (\x -> k x >>= j) = (R h) >>= (\x -> k x >>= j)
= {Reader e.2}
R (\e -> let y = h e
          in runReader ((\x -> k x >>= j) y) e)
= {B-reducción}
R (\e -> let y = h e
          in runReader (k y >>= j) e)
= {Sea k y = R g, g :: e -> b}
R(\e -> let y = h e
         in runReader (R g >>= j) e)
= {Reader e.2}
R (\e -> let y = h e
          in runReader (R (\e' -> let z = g e'
                                   in runReader (j z) e')) e)
= {def. runReader}
R (\e -> let y = h e
          in (\e' -> let z = g e'
                      in runReader (j z) e') e)
= {B-reducción}
R (\e -> let y = h e
          in (let z = g e
               in runReader (j z) e)) (i)

(t >>= k) >>= j = (R h >>= k) >>= j
= {Reader e.2}
(R (\e -> let y = h e
           in runReader (k y) e)) >>= j
= {Sea k y = R g, g :: e -> b}
(R (\e -> let y = h e
          in runReader (R g) e)) >>= j
= {def. runReader}
(R (\e -> let y = h e
           in g e)) >>= j
= {Reader e. 2}
R (\e' -> let z = (\e -> let y = h e
                          in g e) e'
           in runReader (j z) e')
= {B-reducción}
R (\e' -> let z = (let y = h e'
                    in g e')
           in runReader (j z) e')
= {a-conversión: e' = e}
R (\e -> let z = (let y = h e
                   in g e)
          in runReader (j z) e)
= {Reordenamiento de let: y no aparece en runReader (j z) e}
R (\e -> let y = h e
          in (let z = g e
               in runReader (j z) e)) (ii)

Como (i) = (ii), la propiedad vale. //
Como las 3 propiedades valen, (Reader s) es mónada. //

## 2. Definir ask :: Reader e e, que devuelve el entorno.
ask :: Reader e e
ask = R (\e -> e)
```