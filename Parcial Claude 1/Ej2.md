``` haskell
## Sintaxis
t  ::= x | λx : T. t | t t | 0 | suc t | none | some t | case t of none ⇒ t | some x ⇒ t
v  ::= λx : T. t | nv | none | some v
nv ::= 0 | suc nv
T  ::= N | T → T | Opt T

## Sistema de tipos (además de T-Var, T-Abs, T-App, T-Zero, T-Suc)
──────────────────── (T-None)          Γ ⊢ t : T
Γ ⊢ none : Opt T                       ────────────────── (T-Some)
                                       Γ ⊢ some t : Opt T

Γ ⊢ t : Opt T1     Γ ⊢ t1 : T     Γ, x : T1 ⊢ t2 : T
───────────────────────────────────────────────────── (T-Case)
Γ ⊢ case t of none ⇒ t1 | some x ⇒ t2 : T

## Semántica (además de E-App1, E-App2, E-Abs, E-Suc)
      t → t'
──────────────────── (E-Some)
some t → some t'

                        t → t'
───────────────────────────────────────────────────────────────────────── (E-Case)
case t of none ⇒ t1 | some x ⇒ t2  →  case t' of none ⇒ t1 | some x ⇒ t2

case none of none ⇒ t1 | some x ⇒ t2      →  t2            (E-CaseNone)
case (some v) of none ⇒ t1 | some x ⇒ t2  →  t2[v/x]       (E-CaseSome)

## a) Determinar si el siguiente término está bien tipado. Si lo está, dar el árbol de derivación:
case (some 0) of none ⇒ 0 | some x ⇒ suc x
## b) Enunciar los teoremas de progreso y preservación para este lenguaje.
## c) Determinar si valen. Si alguno no vale, dar un contraejemplo.

## a)
{-
case (some 0) of none ⇒ 0 | some x ⇒ suc x

Para usar la regla T-Case, se deben cumplir las siguientes premisas
* Γ ⊢ t : Opt T1 => ∅ ⊢ (some 0) : Opt Nat (por regla T-Some y T-Zero)
* Γ ⊢ t1 : T => ∅ ⊢ 0 : Nat (por regla T-Zero)
* Γ, x : T1 ⊢ t2 : T => x : Nat ⊢ (suc x) : Nat (vale por regla T-Suc)

Luego, podemos realizar el árbol
-}

## b)
{-
Progreso:
Si ∅ ⊢ t : T, entonces t es un valor o existe t' tal que t -> t'

Preservación
Si Γ ⊢ t : T y t -> t', entonces Γ ⊢ t' : T
-}

## c)
{-
Progreso vale.

Veamos preservación
Sea Γ = ∅ y sea t = case none of none ⇒ 0 | some x ⇒ suc x
* t está bien tipado en ∅. Por T-None, ∅ ⊢ none : Opt N. Por T-Zero, ∅ ⊢ 0 : N. Por T-Var, x : N ⊢ x : N, y por T-Suc, x : N ⊢ suc x : N. Entonces, por T-Case (con T1 = N y T = N), ∅ ⊢ t : N.
* t da un paso. Por E-CaseNone, t → suc x.
* suc x no tipa en ∅. Para tiparlo, por T-Suc hace falta ∅ ⊢ x : N, y por T-Var eso requiere x : N ∈ ∅, que es falso. La única regla que da tipo a una variable es T-Var, así que suc x no tiene ningún tipo en ∅.
-}
´´´