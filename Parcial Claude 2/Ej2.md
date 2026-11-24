``` haskell
## Sintaxis
t  ::= x | λx : T. t | t t | true | false | if t then t else t | 0 | suc t | iszero t
v  ::= λx : T. t | true | false | nv
nv ::= 0 | suc nv
T  ::= Bool | N | T → T

## Sistema de tipos (además de T-Var, T-Abs, T-Zero, T-Suc)
─────────────────── (T-True)        ──────────────────── (T-False)
Γ ⊢ true : Bool                     Γ ⊢ false : Bool

Γ ⊢ t1 : Bool    Γ ⊢ t2 : T    Γ ⊢ t3 : T             Γ ⊢ t : N
────────────────────────────────────────── (T-If)     ───────────────────── (T-IsZero)
Γ ⊢ if t1 then t2 else t3 : T                         Γ ⊢ iszero t : Bool

## Semántica (además de E-App1, E-App2, E-Abs, E-Suc)
                       t1 → t1'
──────────────────────────────────────────────── (E-If)
if t1 then t2 else t3 → if t1' then t2 else t3

if true then t2 else t3  → t3        (E-IfTrue)
if false then t2 else t3 → t2        (E-IfFalse)

iszero 0        → true               (E-IsZeroZero)
iszero (suc nv) → false              (E-IsZeroSucc)

## a) Determinar si el siguiente término está bien tipado. Si lo está, dar el árbol de derivación:
(λx : N. if iszero x then 0 else suc x) (suc 0)
## b) Enunciar los teoremas de progreso y preservación para este lenguaje.
## c) Determinar si valen. Si alguno no vale, dar un contraejemplo.

## a)
{-
∅ ⊢ (λx : N. if iszero x then 0 else suc x) (suc 0)
Analicemos el tipo de cada miembro:
suc 0:
  * Por regla T-Zero, 0 : N
  * Por regla T-Suc, suc 0 : N
λx : N. if iszero x then 0 else suc x
  * Por regla T-Var, x : N
  * Por regla T-IsZero, iszero x : Bool
  * Por regla T-Zero, 0 : N
  * Por regla T-Suc, suc x : N
  * Por regla T-If, if iszero x then 0 else suc x : N
  * Por regla T-Abs, λx : N. if iszero x then 0 else suc x : N -> N
(λx : N. if iszero x then 0 else suc x) (suc 0)
  * Por regla T-App, (λx : N. if iszero x then 0 else suc x) (suc 0) : N
Está bien tipado, podemos hacer el árbol.
-}

## b)
{-
Progreso:
Si ∅ ⊢ t : T, entonces t es valor o existe t' tal que t -> t'.

Preservación:
Si Γ ⊢ t : T y t -> t', entonces Γ ⊢ t' : T
-}

## c)
{-
Veamos el progreso:
Sea t = if (iszero ((λx : N. x) 0)) then true else false
* t tipa:
  * Por regla T-Var, x : N
  * Por regla T-Abs, (λx : N. x) : N -> N
  * Por regla T-Zero, 0 : N
  * Por regla T-App, (λx : N. x) 0) : N
  * Por regla T-Iszero, iszero ((λx : N. x) 0) : Bool
  * Por regla T-True, true : Bool
  * Por regla T-False, false : Bool
  * Por regla T-If, t : Bool
* t no es valor: por sintaxis, una construcción de la forma if t1 then t2 else t3 no es valor.
* t no da un paso. Las reglas E-IfTrue y E-IfFalse no aplican porque la condición no es true ni false. E-If no aplica porque la condición debe dar un paso, y solo existen reglas E para isZero cuando su argumento es un valor. En este caso es una aplicación. Luego, no existe t' tal que t -> t'
El progreso no vale.

La preservación vale.
-}
´´´