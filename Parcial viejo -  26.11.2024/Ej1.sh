Nat = ∀X. (X -> X) -> X -> X
Bool = ∀X. X -> X -> X
List X = ∀Y. (X -> Y -> Y) -> Y -> Y

lenLists : ∀X. (X -> Bool) -> List (List X) -> Nat
lenLists = ΛX. λf : X -> Bool. λxxs : List (List X). xxs ⟨Nat⟩ (λxs : List X. λr : Nat. (all ⟨X⟩ f xs) ⟨Nat⟩ (suma (length ⟨X⟩ xs) r) r) 0

# ----- Auxiliares ----- #
# length: calcula la longitud de una lista.
length : ∀X. List X -> Nat
length = ΛX. λxs : List X. xs ⟨Nat⟩ (λx : X. λr : Nat. succ r) 0

# all: determina si todos los elementos de una lista cumplen con el predicado.
all f [] = true
all f (x : xs) = foldr (\x r -> if r then f x else false) true xs

all : ∀X. (X -> Bool) -> List X -> Bool
all = ΛX. λf : X -> Bool. λxs : List X. xs ⟨Bool⟩ (λx : X. λr : Bool. r ⟨Bool⟩ (f x) false) true