``` haskell
Dada la representación en Sistema F:

Nat    = ∀X. (X → X) → X → X
Bool   = ∀X. X → X → X
List X = ∀Y. (X → Y → Y) → Y → Y

y suponiendo definidos true, false, zero, succ, nil, cons y la función not : Bool → Bool:

## a) Definir par : Nat → Bool, que dice si un natural es par.
## b) Definir contarPares : List Nat → Nat, que cuenta cuántos elementos de la lista son pares.

## a)
par 0 = True
par (n + 1) = if par n then false else true

par : Nat -> Bool
par = λn : Nat. n ⟨Bool⟩ not true

## b)
contarPares : List Nat -> Nat
contarPares = λxs : List Nat. length ⟨Nat⟩ (filter ⟨Nat⟩ par xs)

length : ∀X. List X -> Nat
length = ΛX. λxs : List X. xs ⟨Nat⟩ (λx : X. λr : Nat. succ r) zero

filter : ∀X. (X -> Bool) -> List X -> List X
filter f xs = foldr (\x r -> if f x then x : r else r) [] xs
filter = ΛX. λf : X -> Bool. λxs : List X. xs ⟨List X⟩ (λx : X. λr : List X. (f x) ⟨List X⟩ (cons ⟨X⟩ x r) r) (nil ⟨X⟩)
´´´