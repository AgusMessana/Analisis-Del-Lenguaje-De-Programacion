List X = ∀Y : (X -> Y -> Y) -> Y -> Y

# ----- Ejercicio 1 ----- #
# ----- Ejercicio a ----- #
map f [] = []
map f (x : xs) = (f x) : (map f xs)

map f = foldr(\x r -> f x : r) []

map : ∀X. ∀Z. (X -> Z) -> List X -> List Z
map = ΛX. ΛZ. λf : X -> Z. λxs : List X. xs ⟨List Z⟩ (λx : X. λr : List Z. cons ⟨Z⟩ (f x) r) (nil ⟨Z⟩)

# ----- Ejercicio b ----- #
append [] zs = zs
append (x : xs) zs = x : append xs zs

append xs zs = foldr (\x r -> x : r) zs xs

append : ∀X. List X -> List X -> List X
append = ΛX. λxs : List X. λzs : List X. xs ⟨List X⟩ (λx : X. λr: List X. cons ⟨X⟩ x r) zs

# ----- Ejercicio c ----- #
reverse [] = []
reverse (x : xs) = reverse xs ++ [x]

reverse xs = foldr (\x r -> append r [x]) [] xs

reverse : ∀X. List X -> List X
reverse = ΛX. λxs : List X. xs ⟨List X⟩ (λx : X. λr : List X. append ⟨X⟩ r (cons ⟨X⟩ x (nil ⟨X⟩))) (nil ⟨X⟩)

# ----- Ejercicio 2 ----- #
Nat = ∀X. (X -> X) -> X -> X

sum [] = 0
sum (x : xs) = x + sum xs

sum xs = foldr (\x r -> x + r) 0 xs

sum: List Nat -> Nat
sum = λxs : List Nat. xs ⟨Nat⟩ (λx : Nat. λr : Nat. suma x r) 0

suma: Nat -> Nat -> Nat
suma n 0 = n
suma n (m + 1) = succ (suma n m)

suma = λn : Nat. λm : Nat. m ⟨Nat⟩ succ n

# ----- Ejercicio 2 ----- #
insert f [] y = [y]
insert f (x : xs) y = if f x y
                        then x : insert f xs y
                        else y : x : xs

# (la cola original, la cola con y insertado)
insert f xs y = snd (foldr paso base xs)
  where
    base = ([], [y])
    paso x (t, i) = (x : t, if f x y then x : i else y : x : t)

insert : ∀X. (X → X → Bool) → List X → X → List X
insert = ΛX. λf : X -> X -> Bool. λxs : List X. λy : X. sndList (xs ⟨PairList X⟩ paso base)

paso = λx : X. λp : PairList X. pairList (cons ⟨X⟩ x (fstList p)) ((f x y) ⟨List X⟩ (cons ⟨X⟩ x (sndList p)) (cons ⟨X⟩ y (cons ⟨X⟩ x (fstList p))))
base = pairList (nil ⟨X⟩) (cons ⟨X⟩ y (nil ⟨X⟩))

# Auxiliares
PairList X = ∀R. (List X → List X → R) → R

pairList : List X -> List X -> PairList X
pairList = λxs : List X. λys : List X. ΛR. λf : List X -> List X -> R. f xs ys

fstList : PairList X → List X
fstList = λp : PairList X. p ⟨List X⟩ (λxs : List X. λys : List X. xs)

sndList : PairList X → List X
sndList = λp : PairList X. p ⟨List X⟩ (λxs : List X. λys : List X. ys)