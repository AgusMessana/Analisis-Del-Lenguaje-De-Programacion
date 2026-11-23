``` haskell
## Sintaxis
t  ::= x | λx : T. t | t t | 0 | suc t | (t, t) | fst t | snd t
v  ::= λx : T. t | nv | (v, v)
nv ::= 0 | suc nv
T  ::= N | T → T | T × T

## Sistema de tipos
x : T ∈ Γ                Γ, x : T ⊢ t : T'
────────── (T-Var)      ─────────────────────── (T-Abs)
Γ ⊢ x : T                Γ ⊢ λx : T. t : T → T'

Γ ⊢ t1 : T → T'    Γ ⊢ t2 : T
────────────────────────────── (T-App)
Γ ⊢ t1 t2 : T'

────────── (T-Zero)      Γ ⊢ t : N
Γ ⊢ 0 : N               ────────────── (T-Suc)
                         Γ ⊢ suc t : N

Γ ⊢ t1 : T1    Γ ⊢ t2 : T2              Γ ⊢ t : T1 × T2
───────────────────────────── (T-Pair)  ──────────────── (T-Fst)
Γ ⊢ (t1, t2) : T1 × T2                  Γ ⊢ fst t : T1

Γ ⊢ t : T1 × T2
──────────────── (T-Snd)
Γ ⊢ snd t : T2

## Semántica
  t1 → t1'                        t2 → t2'
────────────── (E-App1)        ────────────── (E-App2)
t1 t2 → t1' t2                 v t2 → v t2'

(λx : T. t) v → t[v/x]   (E-Abs)

   t → t'
──────────────── (E-Suc)
suc t → suc t'

       t1 → t1'                            t2 → t2'
────────────────────── (E-Pair1)    ────────────────────── (E-Pair2)
(t1, t2) → (t1', t2)                (v1, t2) → (v1, t2')

   t → t'
────────────── (E-Fst)
fst t → fst t'

fst (v1, v2) → v1    (E-FstPair)
snd (v1, v2) → v1    (E-SndPair)

## a. Enunciar el teorema de progreso y preservación para este lenguaje
{-
Progreso:
si ∅ ⊢ t : T, entonces t es un valor o existe t' tal que t -> t'

Preservación:
si Γ ⊢ t : T y t -> t', entonces Γ ⊢ t' : T
-}

## b. Determinar si valen. Si alguno no vale, dar un contraejemplo que lo demuestre.
{-
Veamos el progreso:
Sea t = snd (fst(0, 0), snd (0, 0)). 
* Por regla T-Zero, 0 : Nat. Por regla T-Pair, (0, 0) : Nat x Nat. Por regla T-Fst, fst (0, 0) : Nat. Por regla T-Snd, snd (0, 0) : Nat. Luego, (fst(0, 0), snd (0, 0)) tiene tipo Nat x Nat por T-Pair. Finalmente, por regla T-Snd, t : Nat
* t no es valor. t es de la forma snd(...), y por sintaxis, esa forma no es un valor.
* t no da un paso. Primeramente, como (fst(0, 0), snd(0, 0)) no es valor (pues de serlo, debería ser de la fomra (v, v), y la primera componente es de la forma fst(...), que según sintaxis, no es valor), no podemos usar la regla E-SndPair. Por otro lado, no existe regla para hacer dar un paso a snd cuando el argumento no es valor. Por lo tanto, no existe t' tal que t -> t'.

Luego, el progreso no vale.
-}

{-
Ahora veamos la preservación:
Sea t = snd ((0, 0), 0)
Veamos el tipo de t:
  * Por regla T-Zero, 0 : Nat
  * Por regla T-Pair, (0, 0) : Nat x Nat
  * Por regla T-Pair, ((0, 0), 0) : (Nat x Nat) x Nat
  * Por regla T-Snd, snd ((0, 0), 0) : Nat
  Luego, t : Nat

Como (0, 0) y 0 son valores por sintaxis, por regla E-SndPair, snd ((0, 0), 0) -> (0, 0) = t'. Luego, t -> t'.

Por lo visto antes, (0, 0) : Nat x Nat. Y no puede tener otro tipo pues la única regla que da tipo a un par es T-Pair, y siempre le da un tipo de la forma T1 x T2.

Por lo tanto, t : Nat, t -> t', pero t' : Nat x Nat, que es distinto al tipo de t.

Luego, la preservación no vale.
-}
´´´